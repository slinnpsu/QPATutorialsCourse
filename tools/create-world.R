#!/usr/bin/env Rscript
#
# create-world.R -- ship `world` in QPATutorialsCourse instead of depending on
#                   poliscidata for it.
#
# WHY
# ---
# Eight tutorials -- T4, T6, T7, T8, T9, T12, T13, T14 -- called
#
#     data("world", package = "poliscidata")
#
# so a large external package had to be installed, and the tutorials would
# break together if it were ever updated or archived. Attaching poliscidata
# also masks this package's own `states`.
#
# WHAT IT DOES
# ------------
# Copies poliscidata::world -- all 167 rows and 103 variables, no subsetting,
# no derived columns -- into data/world.RData, with ONE repair.
#
# THE ONE REPAIR, added 4 August 2026
# -----------------------------------
# poliscidata::world$democ is a factor whose levels are
#
#     "No"  "Yes"  "Yes"
#
# -- three levels for two categories, with "Yes" duplicated. The values are
# sound (No 69, Yes 95, NA 3); the object is not. Any operation that re-levels
# the factor fails, so `table(world$democ)` stops with
#
#     factor level [3] is duplicated
#
# which is what a student exploring the data would meet. The repair rebuilds
# the factor from its own labels with two levels in the same order. No value
# changes; only the levels attribute does.
#
# A scan of all 103 variables on 4 August 2026 found `democ` to be the only
# factor with duplicated levels. The scan is repeated below, so if poliscidata
# ever ships another one, this script reports it rather than passing it on.
#
# This is the only place the copy is not verbatim. Keeping the repair here
# rather than in a separate script means re-running this file cannot silently
# reintroduce the bug.
#
# SAFE TO RE-RUN: it writes the same object every time, and backs up any
# existing data/world.RData first.
#
# USAGE, from the package root (the folder holding DESCRIPTION):
#
#     Rscript tools/create-world.R
#
# or, from an R console in the package root:
#
#     source("tools/create-world.R")

# --------------------------------------------------------------- preflight

if (!dir.exists("data")) {
  stop("No data/ directory here. Run this from the package root ",
       "(the folder holding DESCRIPTION).")
}

if (!requireNamespace("poliscidata", quietly = TRUE)) {
  stop("poliscidata is not installed, so there is nothing to copy from.\n",
       "  install.packages(\"poliscidata\")")
}

# Pull the object without attaching the package, so poliscidata's `states`
# never masks this package's own `states` during the copy.
e <- new.env()
utils::data("world", package = "poliscidata", envir = e)

if (!exists("world", envir = e)) {
  stop("poliscidata does not appear to provide an object called world.")
}

world <- get("world", envir = e)

if (!is.data.frame(world)) {
  stop("poliscidata::world is not a data frame -- it is ", class(world)[1], ".")
}

cat("\nRead poliscidata::world --",
    nrow(world), "rows,", ncol(world), "variables.\n\n")

# Keep an untouched copy so the repair can be shown to have changed one column
# and nothing else.
world_asread <- world

# ------------------------------------------------------- documented columns

# The fourteen variables R/data-world.R describes. If poliscidata ever drops or
# renames one, the codebook and the data would disagree silently, so check.
# `gini10` and `democ` came out of the codebook on 4 August 2026 -- no tutorial
# uses either -- and `gini04` went in, so this list is no longer the same as
# the set of variables the tutorials touch.
documented <- c("country", "dem_level4", "fertility", "spendeduc",
                "lifeex_total", "confidence", "durable", "effectiveness",
                "gdppcap08", "gender_equal3", "gini04", "gini08",
                "regime_type3", "unions")

missing_doc <- setdiff(documented, names(world))
if (length(missing_doc) > 0) {
  stop("These documented variables are not in poliscidata::world: ",
       paste(missing_doc, collapse = ", "),
       "\n  Nothing was written. Update R/data-world.R or investigate.")
}
cat("All", length(documented), "documented variables are present.\n\n")

# `democ` is repaired below and must therefore still be present, even though it
# is no longer documented.
if (!"democ" %in% names(world)) {
  stop("poliscidata::world has no `democ` column, so the repair below has ",
       "nothing to act on.\n  Nothing was written -- read the repair note at ",
       "the head of this file.")
}

# --------------------------------------------- scan for duplicated levels

is_broken <- vapply(
  world,
  function(x) is.factor(x) && anyDuplicated(levels(x)) > 0,
  logical(1)
)
broken <- names(world)[is_broken]

cat("Factors with duplicated levels:",
    if (length(broken) == 0) "none" else paste(broken, collapse = ", "), "\n")

unexpected <- setdiff(broken, "democ")
if (length(unexpected) > 0) {
  stop("Duplicated factor levels in a variable this script does not repair: ",
       paste(unexpected, collapse = ", "),
       "\n  Nothing was written. Decide what to do with these before rerunning.")
}

# ------------------------------------------------------------ repair democ

if ("democ" %in% broken) {
  before <- table(as.character(world$democ), useNA = "ifany")

  cat("\nRepairing `democ`.\n")
  cat("  levels before:", paste(levels(world$democ), collapse = ", "), "\n")

  world$democ <- factor(as.character(world$democ), levels = c("No", "Yes"))

  cat("  levels after: ", paste(levels(world$democ), collapse = ", "), "\n")

  after <- table(as.character(world$democ), useNA = "ifany")
  if (!identical(before, after)) {
    stop("The repair changed the values in `democ`, which it must not.\n",
         "  Nothing was written.")
  }
  cat("  values unchanged: ",
      paste(sprintf("%s %d", names(after), as.integer(after)),
            collapse = "  "), "\n\n")
} else {
  cat("\n`democ` has no duplicated levels -- poliscidata may have fixed it.",
      "\nNothing to repair.\n\n")
}

# ------------------------------------------- prove nothing else was touched

changed <- names(world)[
  !vapply(names(world),
          function(v) identical(world[[v]], world_asread[[v]]),
          logical(1))
]

if (length(changed) > 0 && !identical(changed, "democ")) {
  stop("More than `democ` changed: ", paste(changed, collapse = ", "),
       "\n  Nothing was written.")
}
cat("Columns changed from the poliscidata original:",
    if (length(changed) == 0) "none" else paste(changed, collapse = ", "), "\n\n")

if (!identical(dim(world), dim(world_asread))) {
  stop("Dimensions changed during the repair. Nothing was written.")
}

# ---------------------------------------------- report on documented columns

cat("Documented variables -- class, missing count, and range where numeric:\n")
for (v in documented) {
  x <- world[[v]]
  n_missing <- sum(is.na(x))
  rng <- if (is.numeric(x)) {
    r <- range(x, na.rm = TRUE)
    sprintf("%.2f to %.2f", r[1], r[2])
  } else if (is.factor(x)) {
    paste(nlevels(x), "levels")
  } else {
    ""
  }
  cat(sprintf("  %-16s %-10s NA: %3d   %s\n",
              v, class(x)[1], n_missing, rng))
}
cat("\n")

# --------------------------------------------------------------- back up

target <- file.path("data", "world.RData")

if (file.exists(target)) {
  backup <- paste0(target, ".bak")
  if (file.exists(backup)) {
    cat("NOTE: a backup already exists at", backup, "-- leaving it as it is.\n")
    cat("      It predates this run, so it still holds the pre-repair object.\n\n")
  } else {
    file.copy(target, backup)
    cat("Backed up existing", target, "to", backup, "\n\n")
  }
}

# ------------------------------------------------------------------- write

save(world, file = target, compress = "bzip2", version = 2)

cat("Wrote", target, "--", nrow(world), "rows,", ncol(world), "variables.\n\n")

# ---------------------------------------------------------------------------
# AFTER RUNNING THIS
# ---------------------------------------------------------------------------
#
# Restart R before reading `world` back. The package holds the old object in
# its lazy-load database for the rest of the session, so a check run without a
# restart reports the pre-repair levels and looks like a failure.
#
# Then, with the package reinstalled:
#
#     data("world", package = "QPATutorialsCourse")
#     levels(world$democ)                    # "No" "Yes"
#     table(world$democ, useNA = "ifany")    # 69, 95, 3 -- no error
#
# No tutorial changes. Every tutorial already reads `world` from this package,
# poliscidata is already out of DESCRIPTION, and nothing in T1-T21 uses
# `democ` -- so no number, grader, or figure is affected.
# ---------------------------------------------------------------------------
