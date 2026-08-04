#!/usr/bin/env Rscript
#
# create-world.R -- ship `world` in QPATutorialsCourse instead of depending on
#                   poliscidata for it.
#
# WHY
# ---
# Eight tutorials -- T4, T6, T7, T8, T9, T12, T13, T14 -- call
#
#     data("world", package = "poliscidata")
#
# so a large external package has to be installed, and the tutorials break
# together if it is ever updated or archived. R/data-world.R already documents
# `world` as though it belonged to this package, which it does not, so the
# documentation is currently unreachable and would draw an R CMD check
# complaint. Attaching poliscidata also masks this package's own `states`.
#
# WHAT IT DOES
# ------------
# Copies poliscidata::world verbatim -- all 167 rows and 103 variables, no
# subsetting, no derived columns -- into data/world.RData. Nothing is
# recoded: the tutorials and the codebook both describe the data as
# poliscidata distributes them.
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

# ------------------------------------------------------- documented columns

# The fifteen variables R/data-world.R describes. If poliscidata ever drops or
# renames one, the codebook and the data would disagree silently, so check.
documented <- c("country", "gini10", "dem_level4", "fertility", "spendeduc",
                "lifeex_total", "confidence", "democ", "durable",
                "effectiveness", "gdppcap08", "gender_equal3", "gini08",
                "regime_type3", "unions")

missing_doc <- setdiff(documented, names(world))
if (length(missing_doc) > 0) {
  stop("These documented variables are not in poliscidata::world: ",
       paste(missing_doc, collapse = ", "),
       "\n  Nothing was written. Update R/data-world.R or investigate.")
}
cat("All", length(documented), "documented variables are present.\n\n")

# ---------------------------------------------- report on those columns

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
    cat("NOTE: a backup already exists at", backup, "-- leaving it as it is.\n\n")
  } else {
    file.copy(target, backup)
    cat("Backed up existing", target, "to", backup, "\n\n")
  }
}

# ------------------------------------------------------------------- write

save(world, file = target, compress = "bzip2", version = 2)

cat("Wrote", target, "--", nrow(world), "rows,", ncol(world), "variables.\n\n")

# ---------------------------------------------------------------------------
# AFTER RUNNING THIS, THE FOLLOWING STILL NEED DOING
# ---------------------------------------------------------------------------
#
# 1. In all eight tutorials, change
#
#        data("world", package = "poliscidata")
#    to
#        data("world", package = "QPATutorialsCourse")
#
#    T4, T6, T7, T8, T9, T12, T13, T14. Nothing else about them changes: the
#    object is identical, so every number, grader, and figure stays valid.
#
# 2. Move poliscidata out of Depends/Imports in DESCRIPTION. Check first
#    whether anything else uses it -- as of this writing `world` was the only
#    thing, and `bowl` comes from moderndive, which stays.
#
# 3. Add a @source line to R/data-world.R crediting poliscidata as the
#    compilation, alongside the underlying sources the codebook already names.
#
# 4. Re-run tools/data-usage.R -- world should now appear as a package data
#    file with data() hits in eight tutorials.
#
# 5. Re-run tools/check-chunks.R over inst/tutorials.
# ---------------------------------------------------------------------------
