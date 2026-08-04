#!/usr/bin/env Rscript
#
# check-chunks.R -- parse every R chunk in the QPA tutorials.
#
# Regex checks cannot tell whether R code is syntactically valid. This script
# hands each chunk to R's own parser, so a broken string, an unescaped quote,
# or a stray parenthesis is reported with certainty rather than by inspection.
#
# Each tutorial lives in its own folder, so the search is recursive by default:
# point it at the directory that CONTAINS the tutorial folders and it will find
# every .Rmd beneath it.
#
#     Rscript check-chunks.R                      # recurse from here
#     Rscript check-chunks.R inst/tutorials       # recurse from a folder
#     Rscript check-chunks.R inst/tutorials/07-bivariateCatT/07-bivariateCatT_course.Rmd
#
# Reported paths are shown relative to the search root, so you can tell
# 07-bivariateCatT_course.Rmd from any other file with a similar name.
#
# Exit status is 0 when everything parses and 1 when anything fails, so it can
# be wired into a commit hook later if you want.

# ---------------------------------------------------------------- collect files

args <- commandArgs(trailingOnly = TRUE)

root <- "."
if (length(args) == 0) {
  files <- list.files(".", pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
} else if (length(args) == 1 && dir.exists(args[1])) {
  root  <- args[1]
  files <- list.files(args[1], pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
} else {
  files <- args
}

# Skip anything under a checkpoint/, renv/, or .Rproj.user/ directory, and skip
# knitted copies that sometimes sit beside the source.
files <- files[!grepl("(^|/)(renv|packrat|\\.Rproj\\.user|checkpoint)(/|$)", files)]

files <- sort(unique(files))

if (length(files) == 0) {
  stop("No .Rmd files found under: ", normalizePath(root, mustWork = FALSE))
}

# Show paths relative to the search root so near-identical filenames in
# sibling folders stay distinguishable in the report. Uses substring rather
# than sub(), because a directory name containing a dot would otherwise be
# read as a regular expression.
rel <- function(p) {
  r <- normalizePath(root, mustWork = FALSE)
  n <- normalizePath(p, mustWork = FALSE)
  if (!startsWith(n, r)) return(p)
  out <- substring(n, nchar(r) + 1L)
  sub("^[/\\\\]+", "", out)
}

# ------------------------------------------------------------- chunk extraction

# Returns a list with one element per R chunk: its label, the line the chunk
# header sits on, the header options, and the chunk body.
extract_chunks <- function(path) {
  lines <- readLines(path, warn = FALSE)

  # A chunk header looks like ```{r label, opt = value}. A chunk ends at the
  # next line that is exactly ``` (allowing trailing spaces).
  header_idx <- grep("^\\s*```\\{r[ ,}]", lines)
  fence_idx  <- grep("^\\s*```\\s*$", lines)

  out <- list()
  for (h in header_idx) {
    close <- fence_idx[fence_idx > h]
    if (length(close) == 0) {
      out[[length(out) + 1]] <- list(
        label = "<unterminated>", line = h, opts = lines[h],
        body = "", unterminated = TRUE
      )
      next
    }
    close <- close[1]
    header <- lines[h]
    label  <- sub("^\\s*```\\{r[ ]*", "", header)
    label  <- sub("[,}].*$", "", label)
    label  <- trimws(label)
    if (!nzchar(label)) label <- "<unlabelled>"
    body <- if (close > h + 1) lines[(h + 1):(close - 1)] else character(0)
    out[[length(out) + 1]] <- list(
      label = label, line = h, opts = header,
      body = paste(body, collapse = "\n"), unterminated = FALSE
    )
  }
  out
}

# ------------------------------------------------------------------- the checks

# Starter code for exercises is deliberately incomplete so students can finish
# it. Two conventions are used, and neither will ever parse on its own:
#
#   * ___ blanks for the student to fill in;
#   * a pipeline left open on a trailing operator, e.g. "counties %>%".
#
# learnr never parses the starter -- it is editor text until the student
# submits -- so both are skipped rather than reported. They are counted so the
# totals reconcile.
has_blanks <- function(body) grepl("___", body, fixed = TRUE)

ends_open <- function(body) {
  lines <- unlist(strsplit(body, "\n", fixed = TRUE))
  lines <- lines[nzchar(trimws(lines))]
  if (length(lines) == 0) return(FALSE)
  last <- trimws(lines[length(lines)])
  grepl("(%>%|\\|>|\\+|,|\\(|&&|\\|\\||~)$", last)
}

# Hint chunks are comment-only by convention; they parse fine, so they are
# checked like anything else.

total    <- 0L
skipped  <- 0L
failures <- list()
unterm   <- list()

for (f in files) {
  chunks <- extract_chunks(f)
  for (ch in chunks) {

    if (isTRUE(ch$unterminated)) {
      unterm[[length(unterm) + 1]] <- list(file = f, line = ch$line)
      next
    }

    total <- total + 1L

    if (!nzchar(trimws(ch$body))) next

    if (has_blanks(ch$body) || ends_open(ch$body)) {
      skipped <- skipped + 1L
      next
    }

    err <- tryCatch({
      parse(text = ch$body)
      NULL
    }, error = function(e) conditionMessage(e))

    if (!is.null(err)) {
      failures[[length(failures) + 1]] <- list(
        file = rel(f), label = ch$label, line = ch$line, msg = err
      )
    }
  }
}

# ---------------------------------------------------------------------- report

cat("\n")
cat("Parsed", total, "R chunks across", length(files), "file(s).\n")
cat("Skipped", skipped, "incomplete starter chunk(s) --- ___ blanks or an open pipeline.\n\n")

if (length(unterm) > 0) {
  cat("UNTERMINATED CHUNKS (a missing closing fence):\n")
  for (u in unterm) {
    cat("  ", rel(u$file), " line ", u$line, "\n", sep = "")
  }
  cat("\n")
}

if (length(failures) == 0) {
  cat("No syntax errors.\n\n")
} else {
  cat("SYNTAX ERRORS:", length(failures), "\n\n")
  for (fl in failures) {
    cat("  ", fl$file, "  [", fl$label, "]  header at line ", fl$line, "\n", sep = "")
    # R's parser message is multi-line; indent it so it reads clearly.
    msg <- unlist(strsplit(fl$msg, "\n", fixed = TRUE))
    for (m in msg) cat("      ", m, "\n", sep = "")
    cat("\n")
  }
}

quit(status = if (length(failures) > 0 || length(unterm) > 0) 1L else 0L)
