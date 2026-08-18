#' Open a course reading
#'
#' Opens one of the readings that ship with this package in your web browser.
#' The readings are self-contained HTML files installed alongside the tutorials,
#' so they are available whether or not you have access to a course site.
#'
#' @param name Name of the reading to open, as a string. One of
#'   `"simple-regression"`, `"multiple-regression"`, `"conditional-models"` or
#'   `"logistic-regression"`. Call `open_reading()` with no argument to list
#'   what is available.
#'
#' @return Invisibly, the path to the file that was opened, or the vector of
#'   available reading names when called with no argument.
#'
#' @examples
#' \dontrun{
#' open_reading()
#' open_reading("simple-regression")
#' }
#'
#' @export
open_reading <- function(name) {

  files <- c(
    "simple-regression"   = "SimpleRegression.html",
    "multiple-regression" = "MultipleRegression.html",
    "conditional-models"  = "ConditionalModels.html",
    "logistic-regression" = "LogisticRegression.html"
  )

  if (missing(name)) {
    message(
      "Readings available in QPATutorialsCourse:\n  ",
      paste(names(files), collapse = "\n  "),
      "\n\nFor example: open_reading(\"simple-regression\")"
    )
    return(invisible(names(files)))
  }

  name <- match.arg(name, names(files))

  path <- system.file("readings", files[[name]], package = "QPATutorialsCourse")

  if (!nzchar(path)) {
    stop(
      "Could not find the reading '", name, "'. ",
      "Try reinstalling QPATutorialsCourse.",
      call. = FALSE
    )
  }

  utils::browseURL(path)
  invisible(path)
}
