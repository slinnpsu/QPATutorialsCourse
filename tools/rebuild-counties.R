## rebuild-counties.R -------------------------------------------------------
##
## Rebuilds data/counties.RData so the variables tutorials would otherwise
## construct in their setup chunks ship with the package instead.
##
## Run from the QPATutorialsCourse package root, in a session where the
## package is NOT attached (installing over an attached package is what
## produced the R_decompress1 errors).
##
## RE-RUNNABLE, as of 4 August 2026. Every step tests whether it has already
## been done and SKIPS it, verifying the existing column instead of stopping.
## Section 5 goes further: it recognises a SUPERSEDED definition of
## majority_white and replaces it, so the script converges on the current
## definition from either starting state.
## The earlier version stopped at the first new_col() check, which meant that
## once the rebuild had run on 1 August the script could never be used again --
## the same fault rebuild-fHouse.R had. Nothing is written until every check
## passes.
##
## Note for anyone reading a session back: if this script errors partway, the
## in-memory `counties` is partially modified while the FILE is untouched.
## Always re-load before inspecting values.
## ---------------------------------------------------------------------------

data_file <- file.path("data", "counties.RData")
stopifnot(file.exists(data_file))

## --- load into an isolated environment ------------------------------------
## load() assigns into the target environment and returns the object NAMES,
## so never do `counties <- load(...)`.
e <- new.env()
loaded <- load(data_file, envir = e)
if (!identical(loaded, "counties"))
  stop("Expected data/counties.RData to contain exactly one object named ",
       "'counties'; it contains: ", paste(loaded, collapse = ", "))

counties <- e$counties
stopifnot(is.data.frame(counties))
n_before    <- nrow(counties)
vars_before <- names(counties)

cat("Loaded", n_before, "rows,", length(vars_before), "variables\n\n")

## --- back up before touching anything -------------------------------------
backup <- paste0(data_file, ".bak")
if (!file.exists(backup)) {
  file.copy(data_file, backup)
  cat("Backup written to ", backup, "\n\n", sep = "")
} else {
  cat("Backup already exists at ", backup, " -- leaving it alone.\n",
      "It therefore predates the FIRST run, not this one.\n",
      "If unsure what it holds:\n",
      "  tools::md5sum(c('", data_file, "', '", backup, "'))\n\n", sep = "")
}

## --- helpers ---------------------------------------------------------------

have <- function(nm) nm %in% names(counties)

need_col <- function(nm) {
  ## Explicit membership test, never `$`. Partial matching is what let
  ## counties$rural silently return rural_urban before the setup chunk ran.
  if (!have(nm)) stop("Column not found: ", nm)
  invisible(TRUE)
}

rename_col <- function(from, to) {
  need_col(from)
  if (have(to)) stop("Cannot rename ", from, " to ", to, ": ", to,
                     " already exists.")
  names(counties)[match(from, names(counties))] <<- to
  invisible(TRUE)
}

## Confirms an already-present column still holds what this script would
## build. A mismatch means something other than this script wrote it.
verify <- function(nm, expected, what) {
  if (!isTRUE(all.equal(as.numeric(counties[[nm]]), as.numeric(expected),
                        tolerance = 1e-8))) {
    stop("Column '", nm, "' exists but does not match ", what,
         ". Nothing was written -- investigate before re-running.")
  }
  invisible(TRUE)
}

report <- function(nm) {
  x <- counties[[nm]]
  cat(sprintf("  %-34s min %11.4f  median %11.4f  max %11.4f  NA %d\n",
              nm, min(x, na.rm = TRUE), median(x, na.rm = TRUE),
              max(x, na.rm = TRUE), sum(is.na(x))))
}

skipped <- character(0)
note_skip <- function(nm) skipped <<- c(skipped, nm)

## --- 1. drop the duplicate column ------------------------------------------
## Linc2pvs and dem2p_vote_share_2012 have identical min, median, max and NA
## count. The comparison is printed rather than enforced: the drop is
## deliberate either way, and the backup retains the column.

need_col("dem2p_vote_share_2012")
if (have("Linc2pvs")) {
  cat("Linc2pvs identical to dem2p_vote_share_2012: ",
      identical(counties$Linc2pvs, counties$dem2p_vote_share_2012), "\n",
      "Dropping Linc2pvs.\n\n", sep = "")
  counties$Linc2pvs <- NULL
} else {
  cat("Linc2pvs: already dropped, skipping.\n\n")
  note_skip("Linc2pvs (drop)")
}

## --- 2. rural: 0 urban / 1 neither / 2 rural, from rural_urban -------------
## Nested ifelse() rather than the setup chunks' assign-1-then-overwrite, so
## NA in rural_urban would propagate rather than be masked.

need_col("rural_urban")
if (!is.numeric(counties$rural_urban))
  stop("rural_urban is ", class(counties$rural_urban)[1],
       "; the <= and >= comparisons below assume it is numeric.")

rural_expected <- ifelse(counties$rural_urban <= 3, 0,
                  ifelse(counties$rural_urban >= 8, 2, 1))

if (!have("rural")) {
  counties$rural <- rural_expected
  cat("rural, cross-tabulated against its source:\n")
  print(table(rural = counties$rural,
              rural_urban = counties$rural_urban, useNA = "ifany"))
  cat("\n")
} else {
  verify("rural", rural_expected, "the recode of rural_urban")
  cat("rural: already present and matches rural_urban, skipping.\n\n")
  note_skip("rural")
}

## --- 3. percent twins ------------------------------------------------------
## Each CREATES a new column and leaves the source untouched. Names match what
## T13-T21 already use, including the capital B on Black_percent -- it is
## inconsistent with its siblings, but changing it would break those tutorials.
## Rename later as a deliberate sweep if you want to.

twins <- c(dem2p_percent        = "dem2p_vote_share",
           Black_percent        = "prop_black",
           white_percent        = "prop_white",
           hispanic_percent     = "prop_hispanic",
           college_grad_percent = "prop_college_grad",
           over_65_percent      = "prop_over_65",
           foreignborn_percent  = "prop_foreignborn")

made_twins <- character(0)
for (new in names(twins)) {
  src <- twins[[new]]
  need_col(src)
  if (!have(new)) {
    counties[[new]] <- counties[[src]] * 100
    made_twins <- c(made_twins, new)
  } else {
    verify(new, counties[[src]] * 100, paste0(src, " * 100"))
    note_skip(new)
  }
}

if (length(made_twins)) {
  cat("Percent twins created:\n")
  for (new in made_twins) report(new)
} else {
  cat("Percent twins: all seven already present and verified, skipping.\n")
}
cat("\n")

## --- 4. rescaled variables: rename the original, create the scaled one ------
## The original is kept under a new name, so nothing is overwritten and a
## second run cannot double-scale. The scaled variable takes the name the
## tutorials already reference.
##
##   wage_growth                    proportion, -0.694 to 0.626
##   employ_pop_ratio_25_64         jobs in county / residents 25-64, so values
##                                  above 1 are GENUINE -- a commuting hub
##                                  reaches 6.68, i.e. 668%
##   employ_pop_ratio_25_64_change  same scale as its level, -0.601 to 1.281
##
## NOT rescaled: mortality_risk_25_45 and mortality_risk_25_45_change are the
## probability of dying in the age range and the change in it, and are ALREADY
## in percentage points (level runs 1.07 to 8.39). Multiplying either would be
## wrong. Also left alone: dem2p_vote_share_2012, inc2pvs_change,
## rep2p_vote_share, and the prop_* sources.

rescale <- c(wage_growth                   = "wage_growth_prop",
             employ_pop_ratio_25_64        = "employ_pop_ratio_25_64_raw",
             employ_pop_ratio_25_64_change = "employ_pop_ratio_25_64_change_raw")

made_rescale <- character(0)
for (v in names(rescale)) {
  keep <- rescale[[v]]
  if (!have(keep)) {
    ## first run for this variable: the original is still under its own name
    need_col(v)
    cat("Before rescaling: "); report(v)
    rename_col(v, keep)
    counties[[v]] <- counties[[keep]] * 100
    made_rescale <- c(made_rescale, v)
  } else {
    ## already done: the raw column exists, so v must be the scaled one
    need_col(v)
    verify(v, counties[[keep]] * 100, paste0(keep, " * 100"))
    note_skip(v)
  }
}

if (length(made_rescale)) {
  cat("\nAfter rescaling:\n")
  for (v in made_rescale) report(v)
  cat("Originals retained as:\n")
  for (v in made_rescale) report(rescale[[v]])
} else {
  cat("Rescaled variables: all three already present and verified, skipping.\n")
}
cat("\n")

## --- 5. majority_white: 1 for White Majority counties ----------------------
## Added 4 August 2026 and REDEFINED the same day. Read this before changing it
## again.
##
## T15 built this in its setup chunk as `White`, from prop_white > 0.5, and is
## the only tutorial that uses it. That definition was wrong for what T15 says
## it is doing: Example 3 presents the variable as the four categories of
## `racial_majority` collapsed to a binary, continuing the comparison T13
## makes. prop_white > 0.5 is not that collapse. The two disagree on 95
## counties -- ones racial_majority calls Hispanic Majority and prop_white
## calls majority white, because the Census counts White as a race and
## Hispanic as an ethnicity, so a county can be over half of both.
##
## majority_white is therefore built FROM racial_majority: 1 for
## "White Majority", 0 for the other three categories. That gives 2,866 / 246
## with no missing values, where the superseded definition gave 2,961 / 150
## and one NA inherited from prop_white.
##
## Students do NOT construct this variable, so it ships. They DO construct the
## labelled factor from it, so `White_f` stays in T15's setup chunk.

need_col("racial_majority"); need_col("prop_white")

if (!any(counties$racial_majority == "White Majority", na.rm = TRUE))
  stop("racial_majority holds no \"White Majority\" values; its categories are: ",
       paste(sort(unique(counties$racial_majority)), collapse = ", "),
       ". Nothing was written.")

mw_expected   <- ifelse(counties$racial_majority == "White Majority", 1, 0)
mw_superseded <- ifelse(counties$prop_white > 0.5, 1, 0)

matches <- function(x, y)
  isTRUE(all.equal(as.numeric(x), as.numeric(y), tolerance = 1e-8))

mw_changed <- FALSE
redefined  <- character(0)

if (!have("majority_white")) {
  counties$majority_white <- mw_expected
  mw_changed <- TRUE
  cat("majority_white created from racial_majority.\n")
} else if (matches(counties$majority_white, mw_expected)) {
  cat("majority_white: already present and matches racial_majority, skipping.\n\n")
  note_skip("majority_white")
} else if (matches(counties$majority_white, mw_superseded)) {
  counties$majority_white <- mw_expected
  mw_changed <- TRUE
  redefined  <- "majority_white"
  cat("majority_white: found the superseded prop_white > 0.5 definition.\n",
      "  Replacing it with the racial_majority definition.\n", sep = "")
} else {
  stop("majority_white exists but matches neither the racial_majority ",
       "definition nor the superseded prop_white one. Nothing was written ",
       "-- investigate before re-running.")
}

if (mw_changed) {
  print(table(racial_majority = counties$racial_majority,
              majority_white  = counties$majority_white, useNA = "ifany"))
  cat("\n")
}

## --- 6. verify and write ---------------------------------------------------

added   <- setdiff(names(counties), vars_before)
removed <- setdiff(vars_before, names(counties))

allowed_added <- c("rural", names(twins), unname(rescale), "majority_white")

stopifnot(nrow(counties) == n_before)
if (length(setdiff(added, allowed_added)))
  stop("Unexpected columns added: ",
       paste(setdiff(added, allowed_added), collapse = ", "),
       ". Nothing was written.")
if (length(setdiff(removed, "Linc2pvs")))
  stop("Unexpected columns removed: ",
       paste(setdiff(removed, "Linc2pvs"), collapse = ", "),
       ". Nothing was written.")

cat("Added  (", length(added), "): ",
    if (length(added)) paste(sort(added), collapse = ", ") else "nothing",
    "\nRemoved (", length(removed), "): ",
    if (length(removed)) paste(removed, collapse = ", ") else "nothing",
    "\nRedefined (", length(redefined), "): ",
    if (length(redefined)) paste(redefined, collapse = ", ") else "nothing",
    "\nSkipped as already done (", length(skipped), "): ",
    if (length(skipped)) paste(skipped, collapse = ", ") else "nothing",
    "\nVariables: ", length(vars_before), " -> ", length(names(counties)),
    "\nRows unchanged: ", nrow(counties), "\n\n", sep = "")

cat("Missing-value counts, every variable the tutorials use:\n")
for (v in c("rural", "rural_urban", "racial_majority", "majority_white",
            "TrumpMajority", "dem2p_percent", "dem2p_vote_share",
            "wage_growth", "employ_pop_ratio_25_64",
            "employ_pop_ratio_25_64_change", "prop_college_grad",
            "college_grad_percent", "Black_percent", "white_percent",
            "hispanic_percent", "over_65_percent", "foreignborn_percent",
            "mortality_risk_25_45", "mortality_risk_25_45_change",
            "avg_wkly_wage")) {
  if (have(v))
    cat(sprintf("  %-34s %d\n", v, sum(is.na(counties[[v]]))))
  else
    cat(sprintf("  %-34s (not present)\n", v))
}

save(counties, file = data_file, compress = "bzip2", version = 2)
cat("\nWrote ", data_file, "\n", sep = "")

## --- 7. what still needs doing in the tutorials ----------------------------
##
## The 1 August sweep is COMPLETE, verified 4 August by full-package grep: no
## tutorial rescales wage_growth, rebuilds rural or the percent twins, or
## carries the mortality_risk_25_45_change guard. T12, T13 and T14 now call
## data("counties", package = "QPATutorialsCourse").
##
## STILL TO DO in T15, and it is more than a rename:
##   1. Delete the setup line that builds `counties$White` from prop_white, and
##      point the factor at the shipped column instead:
##      `counties$White_f <- factor(counties$majority_white, labels = ...)`.
##      KEEP `White_f` in setup -- students construct it in a graded exercise,
##      so that grader inspects the submitted CODE, and the model3 grader needs
##      the object in the environment.
##   2. Rename `White` to `majority_white` through the prose, the factor
##      exercise, its three hints and its grader strings.
##   3. RE-DERIVE EXAMPLE 3'S NUMBERS. The definition change moves the split
##      from 2,961 / 150 to 2,866 / 246, so the intercept and slope both
##      change. The superseded values, 63.802 and -32.001, are quoted in
##      answer() messages and must not be left standing.
##   4. The framing sentence claiming the variable collapses racial_majority
##      into a binary is now TRUE, where it was not before. Check it reads
##      correctly against the new derivation rather than assuming it does.
##
## Parked, not part of this rebuild:
##   rural_cat -- T20 and T21 cut() rural_urban into a scheme different from
##     rural. Two encodings of one variable across the sequence.
##   qog$democ / democ_f / rights_f -- defined identically in T16-T19, and
##     rights_f twice within T18.
##   legdata -- T20 sets `legdata <- states`, so it is not a missing object
##     after all; the open question is only whether the alias is worth keeping.
## ---------------------------------------------------------------------------
