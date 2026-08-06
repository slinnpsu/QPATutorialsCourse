#!/usr/bin/env Rscript

# check-labels.R -----------------------------------------------------------
#
# Compares the plot-label strings a GRADER enforces against the strings a
# STUDENT can actually see.  Two questions per graded exercise:
#
#   1. Is every literal the grader requires visible somewhere the student
#      reads -- prose, or a chunk that renders?  A requirement that appears
#      only in a fail message, a hint or fig.alt cannot be met on purpose.
#
#   2. Does any visible chunk print a NEAR-VARIANT of a required caption or
#      axis label?  This is the T9 case: a demonstration plot captioned
#      "Source: Linn, Nagler, and Zilinsky" while the grader two hundred
#      lines below enforced the same string without the "and".  A student
#      copying the demonstration would have failed the check.
#
# Titles are deliberately NOT compared across chunks: each plot has its own
# title and they are supposed to differ.  Captions and axis labels are shared
# boilerplate and should match.
#
# Usage, from the package root:
#     Rscript tools/check-labels.R
#     Rscript tools/check-labels.R inst/tutorials/07-bivariateCat
#
# Base R only.  No packages required.
# --------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
root <- if (length(args) > 0) args[[1]] else "inst/tutorials"

files <- list.files(root, pattern = "\\.Rmd$", recursive = TRUE,
                    full.names = TRUE)

if (length(files) == 0) {
  stop("No .Rmd files found under: ", root, call. = FALSE)
}

FIELDS      <- c("title", "subtitle", "caption", "x", "y")
SHARED      <- c("caption", "x", "y")   # compared across chunks
SIM_CUTOFF  <- 0.85                     # near-variant threshold

# similarity on letters and digits only, so punctuation and case do not matter
similarity <- function(a, b) {
  a <- tolower(gsub("[^A-Za-z0-9]", "", a))
  b <- tolower(gsub("[^A-Za-z0-9]", "", b))
  if (!nzchar(a) || !nzchar(b)) return(0)
  1 - as.numeric(utils::adist(a, b)) / max(nchar(a), nchar(b))
}

# every ```{r label ...} block, with its header and body
get_chunks <- function(lines) {
  opens  <- grep("^```\\{r", lines)
  closes <- grep("^```\\s*$", lines)
  out <- list()
  for (o in opens) {
    cl <- closes[closes > o]
    if (length(cl) == 0) next
    cl <- cl[[1]]
    header <- sub("^```\\{r\\s*", "", lines[[o]])
    header <- sub("\\}\\s*$", "", header)
    name   <- trimws(strsplit(header, ",")[[1]][[1]])
    body   <- if (cl > o + 1) lines[(o + 1):(cl - 1)] else character(0)
    out[[length(out) + 1]] <- list(name = name, body = paste(body, collapse = "\n"))
  }
  out
}

# label = "value" pairs
find_labels <- function(txt) {
  pat <- paste0("\\b(", paste(FIELDS, collapse = "|"), ")\\s*=\\s*\"((?:[^\"\\\\]|\\\\.)*)\"")
  m <- gregexpr(pat, txt, perl = TRUE)
  hits <- regmatches(txt, m)[[1]]
  if (length(hits) == 0) return(NULL)
  field <- sub("\\s*=.*$", "", hits)
  value <- sub("^[^\"]*\"", "", hits)
  value <- sub("\"$", "", value)
  data.frame(field = field, value = value, stringsAsFactors = FALSE)
}

# strings a grader requires
find_enforced <- function(txt) {
  pat <- "(?:plot_labels\\$|\\.result\\$labels\\$)(\\w+)\\s*,\\s*\"((?:[^\"\\\\]|\\\\.)*)\""
  m <- gregexpr(pat, txt, perl = TRUE)
  hits <- regmatches(txt, m)[[1]]
  if (length(hits) == 0) return(NULL)
  field <- sub("^.*\\$", "", sub("\\s*,.*$", "", hits))
  value <- sub("^[^\"]*\"", "", hits)
  value <- sub("\"$", "", value)
  data.frame(field = field, value = value, stringsAsFactors = FALSE)
}

problems <- 0L
checked  <- 0L

for (f in files) {
  lines <- readLines(f, warn = FALSE)

  # prose = everything outside a chunk
  inchunk <- FALSE
  keep <- logical(length(lines))
  for (i in seq_along(lines)) {
    if (grepl("^```", lines[[i]])) { inchunk <- !inchunk; next }
    keep[[i]] <- !inchunk
  }
  prose <- paste(lines[keep], collapse = "\n")

  chunks   <- get_chunks(lines)
  enforced <- list()   # base exercise -> data.frame(field, value)
  shown    <- list()   # base exercise -> data.frame(field, value)

  for (ch in chunks) {
    base    <- sub("-(check|solution|hint-[0-9]+)$", "", ch$name)
    ischeck <- grepl("-check$", ch$name)
    ishint  <- grepl("-hint-[0-9]+$", ch$name)

    if (ischeck) {
      e <- find_enforced(ch$body)
      if (!is.null(e)) enforced[[base]] <- rbind(enforced[[base]], e)
    } else if (!ishint) {
      s <- find_labels(ch$body)
      if (!is.null(s)) shown[[base]] <- rbind(shown[[base]], s)
    }
  }

  msgs <- character(0)

  for (ex in names(enforced)) {
    req <- enforced[[ex]]
    for (k in seq_len(nrow(req))) {
      field <- req$field[[k]]
      want  <- req$value[[k]]
      checked <- checked + 1L

      plain <- gsub("\\\\\"", "\"", want)

      # 1. is it visible anywhere?
      here <- shown[[ex]]
      in_here <- !is.null(here) &&
        any(here$field == field & gsub("\\\\\"", "\"", here$value) == plain)
      in_prose <- grepl(plain, prose, fixed = TRUE) ||
        grepl(want, prose, fixed = TRUE)
      if (!in_here && !in_prose) {
        msgs <- c(msgs, sprintf(
          "    %s [%s]\n        REQUIRED but never shown to the student: \"%s\"",
          ex, field, plain))
      }

      # 2. does another chunk print a near-variant of shared boilerplate?
      if (field %in% SHARED) {
        for (ex2 in names(shown)) {
          s2 <- shown[[ex2]]
          rows <- which(s2$field == field)
          for (r in rows) {
            got <- gsub("\\\\\"", "\"", s2$value[[r]])
            if (identical(got, plain)) next
            if (similarity(got, plain) >= SIM_CUTOFF) {
              msgs <- c(msgs, sprintf(
                "    %s [%s]\n        grader enforces: \"%s\"\n        but %s prints: \"%s\"",
                ex, field, plain, ex2, got))
            }
          }
        }
      }
    }
  }

  msgs <- unique(msgs)
  if (length(msgs) > 0) {
    problems <- problems + length(msgs)
    cat("\n", basename(f), "\n", sep = "")
    cat(paste(msgs, collapse = "\n"), "\n", sep = "")
  }
}

cat("\n", strrep("-", 62), "\n", sep = "")
cat(sprintf("%d enforced label strings checked across %d file(s).\n",
            checked, length(files)))
if (problems == 0) {
  cat("No disagreements between what graders require and what students see.\n")
} else {
  cat(sprintf("%d problem(s) above.\n", problems))
}
