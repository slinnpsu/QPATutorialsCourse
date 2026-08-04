## rebuild-counties.R -------------------------------------------------------
##
## Rebuilds data/counties.RData so the variables currently constructed in
## tutorial setup chunks ship with the package instead.
##
## Run from the QPATutorialsCourse package root, in a session where the
## package is NOT attached (installing over an attached package is what
## produced the R_decompress1 errors).
##
## The script is idempotent in the sense that it never rescales a column in
## place: every scaled variable is a NEW column built from a renamed original.
## Rerunning on already-rebuilt data stops at the first new_col() check rather
## than compounding. Nothing is written until every check passes.
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
n_before   <- nrow(counties)
vars_before <- names(counties)

cat("Loaded", n_before, "rows,", length(vars_before), "variables\n\n")

## --- back up before touching anything -------------------------------------
backup <- paste0(data_file, ".bak")
if (!file.exists(backup)) {
  file.copy(data_file, backup)
  cat("Backup written to ", backup, "\n\n", sep = "")
} else {
  cat("Backup already exists at ", backup, " -- leaving it alone.\n",
      "If unsure it matches the pre-rebuild file:\n",
      "  tools::md5sum(c('", data_file, "', '", backup, "'))\n\n", sep = "")
}

## --- helpers ---------------------------------------------------------------

need_col <- function(nm) {
  ## Explicit membership test, never `$`. Partial matching is what let
  ## counties$rural silently return rural_urban before the setup chunk ran.
  if (!nm %in% names(counties)) stop("Column not found: ", nm)
  invisible(TRUE)
}

new_col <- function(nm) {
  if (nm %in% names(counties))
    stop("Column '", nm, "' already exists -- has this script already run? ",
         "Restore from ", backup, " before re-running.")
  invisible(TRUE)
}

rename_col <- function(from, to) {
  need_col(from); new_col(to)
  names(counties)[match(from, names(counties))] <<- to
  invisible(TRUE)
}

report <- function(nm) {
  x <- counties[[nm]]
  cat(sprintf("  %-32s min %11.4f  median %11.4f  max %11.4f  NA %d\n",
              nm, min(x, na.rm = TRUE), median(x, na.rm = TRUE),
              max(x, na.rm = TRUE), sum(is.na(x))))
}

## --- 1. drop the duplicate column ------------------------------------------
## Linc2pvs and dem2p_vote_share_2012 have identical min, median, max and NA
## count. The comparison is printed rather than enforced: the drop is
## deliberate either way, and the backup retains the column.

need_col("Linc2pvs"); need_col("dem2p_vote_share_2012")
cat("Linc2pvs identical to dem2p_vote_share_2012: ",
    identical(counties$Linc2pvs, counties$dem2p_vote_share_2012), "\n",
    "Dropping Linc2pvs.\n\n", sep = "")
counties$Linc2pvs <- NULL

## --- 2. rural: 0 urban / 1 neither / 2 rural, from rural_urban -------------
## Nested ifelse() rather than the setup chunks' assign-1-then-overwrite, so
## NA in rural_urban would propagate rather than be masked.

need_col("rural_urban"); new_col("rural")
if (!is.numeric(counties$rural_urban))
  stop("rural_urban is ", class(counties$rural_urban)[1],
       "; the <= and >= comparisons below assume it is numeric.")

counties$rural <- ifelse(counties$rural_urban <= 3, 0,
                  ifelse(counties$rural_urban >= 8, 2, 1))

cat("rural, cross-tabulated against its source:\n")
print(table(rural = counties$rural,
            rural_urban = counties$rural_urban, useNA = "ifany"))
cat("\n")

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

for (new in names(twins)) {
  src <- twins[[new]]
  need_col(src); new_col(new)
  counties[[new]] <- counties[[src]] * 100
}

cat("Percent twins created:\n")
for (new in names(twins)) report(new)
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

cat("Before rescaling:\n")
for (v in names(rescale)) { need_col(v); report(v) }

for (v in names(rescale)) {
  rename_col(v, rescale[[v]])
  counties[[v]] <- counties[[ rescale[[v]] ]] * 100
}

cat("\nAfter rescaling:\n")
for (v in names(rescale)) report(v)
cat("\nOriginals retained as:\n")
for (v in names(rescale)) report(rescale[[v]])

## --- 5. verify and write ---------------------------------------------------

added   <- setdiff(names(counties), vars_before)
removed <- setdiff(vars_before, names(counties))

stopifnot(nrow(counties) == n_before)
stopifnot(setequal(added, c("rural", names(twins), unname(rescale))))
stopifnot(setequal(removed, "Linc2pvs"))

cat("\nAdded  (", length(added), "): ", paste(sort(added), collapse = ", "),
    "\nRemoved (", length(removed), "): ", paste(removed, collapse = ", "),
    "\nVariables: ", length(vars_before), " -> ", length(names(counties)),
    "\nRows unchanged: ", nrow(counties), "\n\n", sep = "")

cat("Missing-value counts, every variable the tutorials use:\n")
for (v in c("rural", "rural_urban", "racial_majority", "region",
            "TrumpMajority", "dem2p_percent", "dem2p_vote_share",
            "wage_growth", "employ_pop_ratio_25_64",
            "employ_pop_ratio_25_64_change", "prop_college_grad",
            "college_grad_percent", "Black_percent", "white_percent",
            "hispanic_percent", "over_65_percent", "foreignborn_percent",
            "mortality_risk_25_45", "mortality_risk_25_45_change",
            "avg_wkly_wage")) {
  if (v %in% names(counties))
    cat(sprintf("  %-34s %d\n", v, sum(is.na(counties[[v]]))))
  else
    cat(sprintf("  %-34s (not present)\n", v))
}

save(counties, file = data_file, compress = "bzip2", version = 2)
cat("\nWrote ", data_file, "\n", sep = "")

## --- 6. sweep still required in the tutorials ------------------------------
##
## MUST be done, or the variable is multiplied twice and comes out 100x large:
##   wage_growth, UNGUARDED --
##     T15 l.45, T16 l.39, T18 l.41, T20 l.47, T21 l.44
##
## MUST be done for a different reason -- this guard rescales a variable that
## was already in percentage points, and still will after the rebuild:
##   T8 l.37, the mortality_risk_25_45_change guard. Delete it.
##
## Safe to remove at leisure (each rebuilds from an untouched source column,
## so it reproduces the shipped value rather than corrupting it):
##   rural                 -- T7 l.34, T8 l.43, T12 l.37, T13 l.38
##   dem2p_percent         -- T6, T8, T9, T13, T14, T15, T16, T18, T20, T21
##   *_percent from prop_* -- T16 ll.40-43, T18 ll.42-45, T19 l.57
##   guarded *100          -- T6 ll.38, 41; T8 ll.39, 41; T9 l.38
##
## While sweeping: T12, T13, and T14 mutate `counties` without ever calling
## data("counties", package = "QPATutorialsCourse"). Add the load.
##
## Parked, not part of this rebuild:
##   rural_cat -- T20, T21 cut() rural_urban into a scheme different from rural
##   qog$democ / democ_f / rights_f -- duplicated across T16-T19
##   legdata (T17) is not among the objects in data/ -- source unknown
##   T6 prose gives the employ_pop_ratio_25_64 median as 66.61%; it is 66.81%
