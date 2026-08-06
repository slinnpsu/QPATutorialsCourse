#' Launch a QPATutorialsCourse Tutorial in the Browser
#'
#' Opens a tutorial in your default web browser. This is the recommended
#' way to run tutorials if you are using assistive technology or prefer working
#' in a browser rather than RStudio's internal viewer.
#'
#' Called with no argument, prints the list of all tutorials grouped by topic,
#' with the title and description of each taken from the tutorial itself.
#'
#' @param tutorial A number (1-21) or a name matching part of the tutorial
#'   folder name (e.g., "bivariateCat", "regression", "logit"). Omit it to
#'   print the list of tutorials.
#'
#' @examples
#' \dontrun{
#' qpa_launch()                # list all tutorials
#' qpa_launch(1)               # R Basics Part 1
#' qpa_launch(7)               # Bivariate Description: Categorical
#' qpa_launch("bivariateCat")  # same as above, by name
#' }
#'
#' @export
qpa_launch <- function(tutorial = NULL) {
  tutorials <- qpa_tutorial_dirs()

  if (is.null(tutorial)) {
    return(qpa_tutorial_list())
  }

  if (is.numeric(tutorial)) {
    if (tutorial < 1 || tutorial > length(tutorials)) {
      stop("Tutorial number must be between 1 and ", length(tutorials), ".")
    }
    dir_name <- tutorials[tutorial]
  } else if (is.character(tutorial)) {
    matches <- tutorials[grepl(tutorial, tutorials, ignore.case = TRUE)]
    if (length(matches) == 0) {
      stop(
        "No tutorial found matching '", tutorial, "'.\n",
        "Run qpa_launch() with no argument to see the full list."
      )
    }
    if (length(matches) > 1) {
      stop(
        "Multiple tutorials match '", tutorial, "':\n",
        paste0("  ", matches, collapse = "\n"),
        "\nPlease be more specific or use the tutorial number."
      )
    }
    dir_name <- matches[1]
  } else {
    stop("'tutorial' must be a number or a character string.")
  }

  options(shiny.launch.browser = TRUE)
  learnr::run_tutorial(
    name = dir_name,
    package = "QPATutorialsCourse",
    as_rstudio_job = FALSE,
    shiny_args = list(launch.browser = TRUE)
  )
}


# ---------------------------------------------------------------------------
# The number -> folder map. Unchanged from before; pulled out so that
# qpa_launch() and qpa_tutorial_list() cannot drift apart.
# ---------------------------------------------------------------------------
qpa_tutorial_dirs <- function() {
  c(
    "01-rBasics1",
    "02-rBasics2",
    "03-levels",
    "04-univariateNom",
    "05-univariateOrd",
    "06-univariateInt",
    "07-bivariateCat",
    "08-bivariateCatInt",
    "09-bivariateInt",
    "10-inferencelogic",
    "11-hypothesisConfidence",
    "12-HypTestTwoCat",
    "13-HypTestOneCatOneInt",
    "14-HypTestsTwoInterval",
    "15-regressionSimple",
    "16-regressionMultiple",
    "17-regressionPredictions",
    "18-regressionInteractions",
    "19-regressionPredictionsInteractions",
    "20-logit",
    "21-logitPredictions"
  )
}


# ---------------------------------------------------------------------------
# The only editorial content in this file: which tutorials form a block, and
# what a reader needs before starting the block. Update this when tutorials
# are renumbered.
# ---------------------------------------------------------------------------
qpa_tutorial_blocks <- function() {
  list(
    list(name = "Working in R",              first =  1, last =  2, needs = NULL),
    list(name = "Describing one variable",   first =  3, last =  6, needs = "1-2"),
    list(name = "Describing a relationship", first =  7, last =  9, needs = "3-6"),
    list(name = "Statistical inference",     first = 10, last = 14, needs = "3-9"),
    list(name = "Regression",                first = 15, last = 19, needs = "6, 9, 10-11"),
    list(name = "Logistic regression",       first = 20, last = 21, needs = "15-16")
  )
}


# Internal. Reached through qpa_launch() with no argument, which is the only
# name students need to know. Titles and descriptions are read from each
# tutorial's own YAML header, so they cannot fall out of step with the
# tutorials themselves. Returns the table invisibly, so x <- qpa_launch()
# still gives you a data frame.
qpa_tutorial_list <- function() {
  dirs <- qpa_tutorial_dirs()

  info <- tryCatch(
    as.data.frame(learnr::available_tutorials("QPATutorialsCourse")),
    error = function(e) NULL
  )

  title <- rep(NA_character_, length(dirs))
  desc  <- rep(NA_character_, length(dirs))
  if (!is.null(info) && all(c("name", "title", "description") %in% names(info))) {
    idx <- match(dirs, info$name)
    title <- info$title[idx]
    desc  <- info$description[idx]
  }
  title[is.na(title)] <- dirs[is.na(title)]
  desc[is.na(desc)]   <- ""
  desc <- gsub("\\s+", " ", trimws(desc))

  cat("\nQuantitative Political Analysis: ", length(dirs), " tutorials\n", sep = "")
  for (b in qpa_tutorial_blocks()) {
    header <- paste0("\n  ", b$name)
    if (!is.null(b$needs)) {
      header <- paste0(header, strrep(" ", max(2, 44 - nchar(b$name))),
                       "builds on ", b$needs)
    }
    cat(header, "\n", sep = "")
    for (i in b$first:b$last) {
      cat(sprintf("   %2d  %s\n", i, title[i]))
      if (nzchar(desc[i])) cat("       ", desc[i], "\n", sep = "")
    }
  }
  cat("\nOpen one with qpa_launch(4), or by name with qpa_launch(\"univariateNom\").\n\n")

  invisible(data.frame(
    number = seq_along(dirs), folder = dirs,
    title = title, description = desc,
    stringsAsFactors = FALSE
  ))
}
