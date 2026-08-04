#!/usr/bin/env Rscript
#
# data-usage.R -- which data objects does each .RData file contain, and which
#                 tutorials actually use them?
#
# A file name does not tell you the object name: data/turnout.RData might
# contain an object called TO. This script loads each file in isolation, asks
# R what came out, and then searches the tutorials for those object names.
#
# Usage, from the package root (the folder holding DESCRIPTION):
#
#     Rscript tools/data-usage.R
#     Rscript tools/data-usage.R data inst/tutorials     # non-default paths
#
# For each object it reports three kinds of evidence, weakest last:
#
#   data()   an explicit data("name", package = ...) call -- unambiguous
#   $        a name$variable reference -- unambiguous
#   word     the bare name as a whole word -- may be a false positive, since
#            an object called "oil" matches the English word "oil"
#
# An object with no data() and no $ hits is a candidate for removal, but read
# the word hits before deciding.

args <- commandArgs(trailingOnly = TRUE)
data_dir <- if (length(args) >= 1) args[1] else "data"
tut_dir  <- if (length(args) >= 2) args[2] else file.path("inst", "tutorials")

if (!dir.exists(data_dir)) stop("No such directory: ", data_dir)
if (!dir.exists(tut_dir))  stop("No such directory: ", tut_dir)

# ----------------------------------------------------------- the data files

data_files <- list.files(data_dir, pattern = "\\.(RData|rda|Rda|rdata)$",
                         full.names = TRUE)
if (length(data_files) == 0) stop("No .RData files found in ", data_dir)

# ------------------------------------------------------------ the tutorials

rmd_files <- list.files(tut_dir, pattern = "\\.Rmd$",
                        recursive = TRUE, full.names = TRUE)
if (length(rmd_files) == 0) stop("No .Rmd files found under ", tut_dir)

rmd_text <- lapply(rmd_files, function(f) paste(readLines(f, warn = FALSE),
                                                collapse = "\n"))
names(rmd_text) <- basename(rmd_files)

cat("\nScanning", length(data_files), "data file(s) against",
    length(rmd_files), "tutorial(s).\n\n")

# --------------------------------------------------------------- inspect

# Load into a throwaway environment so nothing leaks between files or into
# the caller's workspace.
objects_in <- function(path) {
  e <- new.env()
  nm <- tryCatch(load(path, envir = e), error = function(err) character(0))
  out <- lapply(nm, function(n) {
    x <- get(n, envir = e)
    list(name = n,
         class = class(x)[1],
         rows = if (is.data.frame(x)) nrow(x) else NA_integer_,
         cols = if (is.data.frame(x)) ncol(x) else NA_integer_)
  })
  out
}

unused <- character(0)

for (f in data_files) {

  objs <- objects_in(f)

  cat("=====", basename(f), "\n")
  if (length(objs) == 0) {
    cat("  (could not be loaded)\n\n")
    next
  }

  for (o in objs) {

    dims <- if (is.na(o$rows)) o$class else
      paste0(o$class, ", ", o$rows, " x ", o$cols)
    cat("  object: ", o$name, "  (", dims, ")\n", sep = "")

    nm <- o$name

    # Three searches, strongest evidence first.
    pat_data <- paste0("data\\(\\s*[\"']", nm, "[\"']")
    pat_dollar <- paste0("(^|[^A-Za-z0-9._])", nm, "\\$")
    pat_word <- paste0("(^|[^A-Za-z0-9._])", nm, "([^A-Za-z0-9._]|$)")

    hits <- list(data = character(0), dollar = character(0), word = character(0))

    for (tf in names(rmd_text)) {
      txt <- rmd_text[[tf]]
      n_data   <- length(gregexpr(pat_data, txt)[[1]][gregexpr(pat_data, txt)[[1]] > 0])
      n_dollar <- length(gregexpr(pat_dollar, txt)[[1]][gregexpr(pat_dollar, txt)[[1]] > 0])
      n_word   <- length(gregexpr(pat_word, txt)[[1]][gregexpr(pat_word, txt)[[1]] > 0])

      if (n_data   > 0) hits$data   <- c(hits$data,   sprintf("%s (%d)", tf, n_data))
      if (n_dollar > 0) hits$dollar <- c(hits$dollar, sprintf("%s (%d)", tf, n_dollar))
      if (n_word   > 0) hits$word   <- c(hits$word,   sprintf("%s (%d)", tf, n_word))
    }

    show <- function(label, v) {
      if (length(v) == 0) {
        cat("      ", label, ": none\n", sep = "")
      } else {
        cat("      ", label, ": ", paste(v, collapse = ", "), "\n", sep = "")
      }
    }
    show("data()", hits$data)
    show("$     ", hits$dollar)
    show("word  ", hits$word)

    if (length(hits$data) == 0 && length(hits$dollar) == 0) {
      unused <- c(unused, paste0(nm, "  (", basename(f), ")"))
      if (length(hits$word) == 0) {
        cat("      >>> NO REFERENCES AT ALL -- safe to remove.\n")
      } else {
        cat("      >>> no data() or $ use -- check the word hits before removing.\n")
      }
    }
    cat("\n")
  }
}

# ----------------------------------------------------------------- summary

cat("\n")
if (length(unused) == 0) {
  cat("Every object is referenced with data() or $ somewhere.\n\n")
} else {
  cat("CANDIDATES FOR REMOVAL -- no data() call and no $ reference:\n")
  for (u in unused) cat("  ", u, "\n", sep = "")
  cat("\nRead their word hits above before deleting: a short object name can\n")
  cat("match an ordinary English word in prose.\n\n")
}
