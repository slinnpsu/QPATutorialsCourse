#!/usr/bin/env Rscript
#
# rebuild-fHouse.R -- rebuild data/fHouse.RData for QPATutorialsCourse.
#
# WHY
# ---
# Tutorial 5 currently recodes Freedom House status inside its setup chunk:
#
#     fHouse$FHStatus <- unname(c("NF" = 0, "PF" = 1, "F" = 2)[fHouse$FHStatus])
#
# so the variable students work with is not the variable the codebook
# documents. This script ships the recode instead, following the same decision
# made for `counties` on 1 August 2026: variables that no exercise asks the
# student to construct belong in the data, not in a setup chunk.
#
# WHAT IT DOES
# ------------
#   RENAME  FHStatus -> FHStatus_raw   (the original "F" / "PF" / "NF" strings,
#                                       kept so this script is idempotent)
#   CREATE  FHStatus                   numeric 0/1/2, 8 NA
#   CREATE  FHStatus_f                 factor, levels Not Free < Partly Free
#                                       < Free in that display order, 8 NA
#
# The eight blank strings in the shipped data become NA in both new variables,
# because a blank is not one of the three recognised codes. That is deliberate:
# T5's FHStatus example exists precisely because the variable has gaps, in
# contrast with rural_urban, which has none.
#
# IDEMPOTENT: if FHStatus_raw already exists the script stops rather than
# recoding an already-numeric FHStatus into all-NA.
#
# USAGE, from the package root (the folder holding DESCRIPTION):
#
#     Rscript tools/rebuild-fHouse.R
#
# or, from an R console in the package root:
#
#     source("tools/rebuild-fHouse.R")

# ------------------------------------------------------------------- locate

data_file <- file.path("data", "fHouse.RData")

if (!file.exists(data_file)) {
  stop("Could not find ", data_file,
       ". Run this from the package root (the folder holding DESCRIPTION).")
}

# ------------------------------------------------------- load in isolation

# Load into its own environment so nothing in the caller's workspace is
# touched, and so we know exactly which object came out of the file.
env <- new.env()
loaded <- load(data_file, envir = env)

if (!"fHouse" %in% loaded) {
  stop(data_file, " does not contain an object called fHouse. It contains: ",
       paste(loaded, collapse = ", "))
}

fHouse <- get("fHouse", envir = env)

cat("\nLoaded", data_file, "--",
    nrow(fHouse), "rows,", ncol(fHouse), "variables.\n\n")

# ------------------------------------------------------- idempotence guard

if ("FHStatus_raw" %in% names(fHouse)) {
  stop("FHStatus_raw already exists, so this rebuild has already been run.\n",
       "  Recoding again would turn the numeric FHStatus into all-NA.\n",
       "  Restore data/fHouse.RData.bak first if you need to re-run.")
}

if (!is.character(fHouse$FHStatus)) {
  stop("FHStatus is not a character vector -- it is ", class(fHouse$FHStatus)[1],
       ".\n  Expected the original \"F\" / \"PF\" / \"NF\" codes. Nothing changed.")
}

# ---------------------------------------------------------------- back up

backup <- paste0(data_file, ".bak")
if (file.exists(backup)) {
  cat("NOTE: a backup already exists at", backup, "-- leaving it as it is.\n")
  cat("      It is therefore the state before the FIRST run, not this one.\n\n")
} else {
  file.copy(data_file, backup)
  cat("Backed up to", backup, "\n\n")
}

# --------------------------------------------------------- what is in there

cat("FHStatus as shipped:\n")
before <- table(fHouse$FHStatus, useNA = "ifany")
for (i in seq_along(before)) {
  lab <- names(before)[i]
  if (is.na(lab)) lab <- "<NA>" else if (!nzchar(lab)) lab <- "<blank>"
  cat(sprintf("  %-10s %5d\n", lab, before[i]))
}
cat("\n")

# ------------------------------------------------------------- rebuild

# 1. keep the original codes under a new name
fHouse$FHStatus_raw <- fHouse$FHStatus

# 2. numeric 0/1/2; anything else -- including the blanks -- becomes NA
lookup <- c("NF" = 0, "PF" = 1, "F" = 2)
fHouse$FHStatus <- unname(lookup[fHouse$FHStatus_raw])

# 3. factor built FROM the numeric, so the two can never drift apart.
#    Unordered on purpose: an ordered factor changes model contrasts and
#    prints levels with < signs, neither of which helps at this stage. The
#    order below is the display order the tutorials rely on.
fHouse$FHStatus_f <- factor(fHouse$FHStatus,
                            levels = c(0, 1, 2),
                            labels = c("Not Free", "Partly Free", "Free"))

# ------------------------------------------------------------------ report

cat("FHStatus after recoding (numeric):\n")
after <- table(fHouse$FHStatus, useNA = "ifany")
for (i in seq_along(after)) {
  lab <- names(after)[i]
  if (is.na(lab)) lab <- "<NA>"
  cat(sprintf("  %-10s %5d\n", lab, after[i]))
}
cat("\n")

cat("FHStatus_f (factor):\n")
fac <- table(fHouse$FHStatus_f, useNA = "ifany")
for (i in seq_along(fac)) {
  lab <- names(fac)[i]
  if (is.na(lab)) lab <- "<NA>"
  cat(sprintf("  %-14s %5d\n", lab, fac[i]))
}
cat("\n")

cat("Levels of FHStatus_f, in stored order:\n")
cat(" ", paste(levels(fHouse$FHStatus_f), collapse = " | "), "\n\n")

# The three views must agree case by case. This is the check that matters:
# if it fails, the lookup or the labels are wrong.
agree <- all(
  (is.na(fHouse$FHStatus) & is.na(fHouse$FHStatus_f)) |
    (as.integer(fHouse$FHStatus_f) - 1L) == fHouse$FHStatus,
  na.rm = FALSE
)
cat("Numeric and factor agree case by case:", agree, "\n")

raw_ok <- all(
  (is.na(fHouse$FHStatus) & !(fHouse$FHStatus_raw %in% names(lookup))) |
    (!is.na(fHouse$FHStatus) & fHouse$FHStatus_raw %in% names(lookup)),
  na.rm = FALSE
)
cat("Every NA traces to a code outside F/PF/NF:", raw_ok, "\n")

cat("Missing values -- FHStatus:", sum(is.na(fHouse$FHStatus)),
    " FHStatus_f:", sum(is.na(fHouse$FHStatus_f)), "\n\n")

if (!agree || !raw_ok) {
  stop("A consistency check failed. Nothing was written.")
}

# ------------------------------------------------------------------- write

save(fHouse, file = data_file, compress = "bzip2", version = 2)

cat("Wrote", data_file, "--",
    nrow(fHouse), "rows,", ncol(fHouse), "variables.\n")
cat("Variables now:", paste(names(fHouse), collapse = ", "), "\n\n")

# ---------------------------------------------------------------------------
# AFTER RUNNING THIS, THE FOLLOWING STILL NEED DOING
# ---------------------------------------------------------------------------
#
# 1. T5 setup chunk: delete the recode line and its two-line comment.
#    Only T5 uses fHouse, and the strings "F" / "PF" / "NF" appear nowhere
#    else in the package, so nothing else references the old coding.
#
# 2. data-fHouse.R: document FHStatus (numeric 0/1/2), FHStatus_f (factor),
#    and FHStatus_raw (the original codes), and say that the eight blanks
#    become NA in the two new variables.
#
# 3. Re-run T5's Practice 9 to confirm the median is unchanged. Its grader
#    computes the expected value from fHouse directly, so it will follow the
#    data -- but the printed answer in the surrounding prose will not.
#
# 4. Re-run tools/check-chunks.R over inst/tutorials.
# ---------------------------------------------------------------------------
