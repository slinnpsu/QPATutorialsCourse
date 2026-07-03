#' Launch a QPATutorialsCourse Tutorial in the Browser
#'
#' Opens a tutorial in your default web browser. This is the recommended
#' way to run tutorials if you are using assistive technology or prefer working
#' in a browser rather than RStudio's internal viewer.
#'
#' @param tutorial A number (1-20) or a name matching part of the tutorial
#'   folder name (e.g., "bivariateCat", "regression", "logit").
#'
#' @examples
#' \dontrun{
#' qpa_launch(1)               # R Basics Part 1
#' qpa_launch(7)               # Bivariate Description: Categorical
#' qpa_launch("bivariateCat")  # same as above, by name
#' qpa_launch("regression")    # matches first tutorial with "regression" in name
#' }
#'
#' @export
qpa_launch <- function(tutorial) {

  tutorials <- c(
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
    "17-regressionInteractions",
    "18-regressionPredictions",
    "19-logit",
    "20-logitPredictions"
  )

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
        "Available tutorials:\n",
        paste0("  ", seq_along(tutorials), ". ", tutorials, collapse = "\n")
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

  # Kill any existing process on port 3838
  suppressWarnings({
    pid <- system("lsof -ti :3838", intern = TRUE)
    if (length(pid) > 0) {
      system(paste("kill -9", paste(pid, collapse = " ")))
      Sys.sleep(3)
    }
  })

  # Start tutorial in background
  p <- callr::r_bg(
    function(dir_name, port) {
      learnr::run_tutorial(
        name = dir_name,
        package = "QPATutorialsCourse",
        shiny_args = list(port = port, launch.browser = FALSE)
      )
    },
    args = list(dir_name = dir_name, port = 3838),
    stdout = file.path(tempdir(), "qpa_out.txt"),
    stderr = file.path(tempdir(), "qpa_err.txt"),
    package = TRUE
  )

  saveRDS(p, file.path(tempdir(), "qpa_tutorial_process.rds"))

  # Wait for server to be ready (up to 30 seconds)
  url <- "http://127.0.0.1:3838"
  for (i in 1:30) {
    Sys.sleep(1)
    result <- tryCatch(
      { readLines(url, n = 1, warn = FALSE); TRUE },
      error = function(e) FALSE
    )
    if (result) break
  }

  system2("open", url)
  message("Tutorial running at ", url)
  message("Run qpa_launch() again to switch tutorials.")
}
