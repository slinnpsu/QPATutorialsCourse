# tools/copy-readings.R
#
# Copies the rendered readings that ship with the package from readings/ into
# inst/readings/. Run it after re-rendering any reading:
#
#   source("tools/copy-readings.R")
#
# Then reinstall the package (Build > Install and Restart) so the new files are
# the ones students open.
#
# The Research Process reading is deliberately NOT copied. It is tied to no
# tutorial and is written around this course, so it stays out of the installed
# package. It still renders to readings/ for posting to Canvas.

copy_readings <- function() {

  if (!file.exists("DESCRIPTION")) {
    stop(
      "This script must be run from the package root.\n",
      "Working directory is currently: ", getwd(),
      call. = FALSE
    )
  }

  shipped <- c(
    "SimpleRegression.html",
    "MultipleRegression.html",
    "ConditionalModels.html",
    "LogisticRegression.html"
  )

  from <- file.path("readings", shipped)

  missing <- !file.exists(from)
  if (any(missing)) {
    stop(
      "These files are not in readings/:\n  ",
      paste(shipped[missing], collapse = "\n  "),
      "\nRender the readings before running this script.",
      call. = FALSE
    )
  }

  dir.create("inst/readings", recursive = TRUE, showWarnings = FALSE)
  ok <- file.copy(from, "inst/readings", overwrite = TRUE)

  for (i in seq_along(shipped)) {
    cat(if (ok[i]) "  copied  " else "  FAILED  ", shipped[i], "\n", sep = "")
  }

  if (all(ok)) {
    cat("\nAll four readings updated. Reinstall the package to see the changes.\n")
  } else {
    cat("\nSome files did not copy. Check the permissions on inst/readings/.\n")
  }

  invisible(ok)
}

copy_readings()
