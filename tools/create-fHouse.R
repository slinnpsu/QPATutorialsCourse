#!/usr/bin/env Rscript
#
# create-fHouse.R -- build data/fHouse.RData from the World Values Survey and
#                    the Quality of Government Standard Time-Series.
#
# WHY TWO FREEDOM HOUSE VINTAGES
# ------------------------------
# T5 and T15 want different things from the same measure, and no single year
# serves both.
#
#   T15 regresses attitudes on freedom, so the Freedom House scores must be
#   measured BEFORE the surveys. WVS Wave 7 fielding begins in 2017, so 2016
#   is the latest year that precedes every survey in the file.
#
#   T5 describes the distribution of Freedom House status across countries.
#   2016 would be as dated as the Wave 5 data this replaces, so it wants the
#   current vintage.
#
# So the Freedom House block is carried twice, suffixed by year: every variable
# exists as `<name>_2016` and `<name>_2022`. T5 uses the 2022 status, T15 uses
# the 2016 total, and each is right for its purpose. The suffix also makes the
# vintage visible at the point of use rather than buried in documentation --
# which is the failure that put a decade-long gap into the previous version of
# this dataset without anyone noticing.
#
# STATUS CODING
# -------------
# QoG distributes fh_status as 1 Free, 2 Partly Free, 3 Not Free. That is the
# reverse of what T5 teaches, so this script also ships `FHStatus_<year>` as
# 0 Not Free, 1 Partly Free, 2 Free -- ascending in freedom, which is what
# makes it ordinal in the direction T5 describes -- and `FHStatus_f_<year>` as
# the labelled factor in that display order. `fh_status_<year>` is kept
# unmodified, so the recode is always reversible and checkable.
#
# SOURCE FILES ARE NOT DISTRIBUTED
# --------------------------------
# The two inputs are large files outside the package. Edit `data_folder` below
# if they move. This script cannot run on a machine that does not have them,
# which is the price of recording where the data came from; without it,
# nothing in the package says how fHouse was built.
#
# SAFE TO RE-RUN: it rebuilds the same object every time and backs up any
# existing data/fHouse.RData first.
#
# USAGE, from the package root (the folder holding DESCRIPTION):
#
#     Rscript tools/create-fHouse.R
#
# or, from an R console in the package root:
#
#     source("tools/create-fHouse.R")

suppressPackageStartupMessages(library(dplyr))

FH_YEARS  <- c(2016, 2022)
UNIVERSE_YEAR <- 2024

# --------------------------------------------------------------- preflight

if (!dir.exists("data")) {
  stop("No data/ directory here. Run this from the package root ",
       "(the folder holding DESCRIPTION).")
}

data_folder <- paste0(
  "/Users/sld8/Dropbox/PLSC309/PLSC309FA2026/",
  "TutorialData/WVS/"
)

wvs_file <- paste0(data_folder,
                   "WVS_Cross-National_Wave_7_Rdata_v6_0.rdata")
qog_file <- paste0(data_folder, "qog_std_ts_jan26.csv")

for (f in c(wvs_file, qog_file)) {
  if (!file.exists(f)) {
    stop("Source file not found:\n  ", f,
         "\nThese inputs live outside the package. Edit `data_folder` at the ",
         "head of this script if they have moved.")
  }
}

# ------------------------------------------- World Values Survey, Wave 7

# Respondent-level, aggregated to country using the WVS weight.
#
#   Q235 -- having a strong leader who does not have to bother with
#           parliament and elections
#   Q238 -- having a democratic political system
#
# Both are 1 very good / 2 fairly good / 3 fairly bad / 4 very bad. Codes
# outside 1--4 are the survey's missing-data conventions and become NA.
# `Pro.*` is the percentage choosing 1 or 2; `Mean.*` is the weighted mean of
# the 1--4 scale, where LOWER means more supportive.

load(wvs_file)
wvs7 <- get("WVS_Cross-National_Wave_7_v6_0")

wvs_country <- wvs7 %>%
  mutate(
    Q235_valid = if_else(Q235 %in% 1:4, as.numeric(Q235), NA_real_),
    Q238_valid = if_else(Q238 %in% 1:4, as.numeric(Q238), NA_real_),
    support_strong = if_else(is.na(Q235_valid), NA_real_,
                             as.numeric(Q235_valid %in% c(1, 2))),
    support_dem    = if_else(is.na(Q238_valid), NA_real_,
                             as.numeric(Q238_valid %in% c(1, 2)))
  ) %>%
  group_by(B_COUNTRY, B_COUNTRY_ALPHA, A_YEAR) %>%
  summarise(
    Pro.Strong.Leader  = weighted.mean(support_strong, W_WEIGHT,
                                       na.rm = TRUE) * 100,
    Pro.Dem            = weighted.mean(support_dem, W_WEIGHT,
                                       na.rm = TRUE) * 100,
    Mean.Strong.Leader = weighted.mean(Q235_valid, W_WEIGHT, na.rm = TRUE),
    Mean.Dem           = weighted.mean(Q238_valid, W_WEIGHT, na.rm = TRUE),
    .groups = "drop"
  )

cat("\nWVS Wave 7: ", nrow(wvs_country), " country-waves, fielded ",
    min(wvs_country$A_YEAR), "-", max(wvs_country$A_YEAR), "\n", sep = "")

# ------------------------------------ Quality of Government time series

qog <- read.csv(qog_file)

for (v in c("year", "ccode", "ccodealp", "cname")) {
  if (!v %in% names(qog))
    stop("The QoG file has no column called '", v, "'.")
}

# The country universe: every country present in the most recent QoG year.
# Countries with no Freedom House match keep their row with missing scores --
# Sudan is one -- so the file describes a universe rather than only the
# countries that happen to be complete.
country_universe <- qog %>%
  filter(year == UNIVERSE_YEAR, !is.na(ccodealp)) %>%
  distinct(ccode, ccodealp, cname)

cat("Country universe (QoG ", UNIVERSE_YEAR, "): ",
    nrow(country_universe), " countries\n\n", sep = "")

# ------------------------------------------- one Freedom House vintage

fh_components <- c("fh_ep", "fh_ppp", "fh_fog",           # political rights
                   "fh_feb", "fh_aor", "fh_rol", "fh_pair")  # civil liberties
fh_source     <- c("fh_status", "fh_pr", "fh_cl", fh_components)

missing_cols <- setdiff(fh_source, names(qog))
if (length(missing_cols))
  stop("The QoG file has no Freedom House columns: ",
       paste(missing_cols, collapse = ", "))

fh_block <- function(yr) {
  d <- qog %>%
    filter(year == yr, !is.na(ccodealp)) %>%
    select(ccode, ccodealp, cname, all_of(fh_source))

  if (nrow(d) == 0)
    stop("The QoG file has no rows for year ", yr, ".")

  for (v in fh_source) {
    if (all(is.na(d[[v]])))
      stop("Every value of ", v, " is missing in ", yr,
           ". Freedom House may not report it that far back; ",
           "nothing was written.")
  }

  d <- d %>%
    mutate(
      PFHR.Aggr   = fh_ep + fh_ppp + fh_fog,
      FHCLAggr    = fh_feb + fh_aor + fh_rol + fh_pair,
      FHTotalAggr = PFHR.Aggr + FHCLAggr,
      # QoG: 1 Free, 2 Partly Free, 3 Not Free.
      # T5: 0 Not Free, 1 Partly Free, 2 Free. Hence 3 - fh_status.
      FHStatus    = 3 - fh_status,
      FHStatus_f  = factor(3 - fh_status,
                           levels = c(0, 1, 2),
                           labels = c("Not Free", "Partly Free", "Free"))
    )

  ## suffix everything except the three join keys
  keys <- c("ccode", "ccodealp", "cname")
  vars <- setdiff(names(d), keys)
  names(d)[match(vars, names(d))] <- paste0(vars, "_", yr)
  d
}

fHouse <- country_universe
for (yr in FH_YEARS) {
  fHouse <- left_join(fHouse, fh_block(yr),
                      by = c("ccode", "ccodealp", "cname"))
  cat("Freedom House ", yr, " joined.\n", sep = "")
}

# --------------------------------------------------- join the survey data

# HKG, MAC, PRI and NIR are surveyed by the WVS but are not countries in the
# QoG universe, so they do not match and are not carried.
fHouse <- left_join(fHouse, wvs_country,
                    by = c("ccodealp" = "B_COUNTRY_ALPHA"))

fHouse <- fHouse %>%
  rename(Country.Code = ccodealp,
         Country      = cname,
         WVS_year     = A_YEAR) %>%
  select(ccode, Country.Code, Country, WVS_year,
         ends_with("_2016"), ends_with("_2022"),
         Pro.Strong.Leader, Pro.Dem, Mean.Strong.Leader, Mean.Dem)

cat("\n")

# ------------------------------------------------------------------ verify

surveyed <- !is.na(fHouse$WVS_year)

cat("Rows: ", nrow(fHouse), "   Variables: ", ncol(fHouse), "\n", sep = "")
cat("Countries with survey data: ", sum(surveyed), "\n", sep = "")
cat("WVS fielding years: ", min(fHouse$WVS_year, na.rm = TRUE), "-",
    max(fHouse$WVS_year, na.rm = TRUE), "\n\n", sep = "")

## The point of the 2016 vintage: it must precede every survey.
if (min(fHouse$WVS_year, na.rm = TRUE) <= 2016) {
  stop("At least one country was surveyed in ",
       min(fHouse$WVS_year, na.rm = TRUE),
       ", so the 2016 Freedom House scores do not precede every survey. ",
       "Nothing was written -- the vintage needs rethinking.")
}
cat("Temporal ordering: every survey postdates the 2016 scores (earliest ",
    min(fHouse$WVS_year, na.rm = TRUE), ").\n", sep = "")

## Numeric and factor status must agree, in both vintages.
for (yr in FH_YEARS) {
  num <- fHouse[[paste0("FHStatus_", yr)]]
  fac <- fHouse[[paste0("FHStatus_f_", yr)]]
  ok <- all((is.na(num) & is.na(fac)) |
              (as.integer(fac) - 1L) == num, na.rm = FALSE)
  if (!ok)
    stop("FHStatus_", yr, " and FHStatus_f_", yr,
         " disagree. Nothing was written.")
  raw <- fHouse[[paste0("fh_status_", yr)]]
  if (!isTRUE(all.equal(as.numeric(num), 3 - as.numeric(raw))))
    stop("FHStatus_", yr, " is not 3 - fh_status_", yr,
         ". Nothing was written.")
}
cat("Status coding: numeric, factor and source agree in both vintages.\n")

## The aggregates must be the sums of their components.
for (yr in FH_YEARS) {
  g <- function(v) fHouse[[paste0(v, "_", yr)]]
  if (!isTRUE(all.equal(g("PFHR.Aggr"), g("fh_ep") + g("fh_ppp") + g("fh_fog"))))
    stop("PFHR.Aggr_", yr, " is not the sum of its components.")
  if (!isTRUE(all.equal(g("FHCLAggr"),
                        g("fh_feb") + g("fh_aor") + g("fh_rol") + g("fh_pair"))))
    stop("FHCLAggr_", yr, " is not the sum of its components.")
  if (!isTRUE(all.equal(g("FHTotalAggr"), g("PFHR.Aggr") + g("FHCLAggr"))))
    stop("FHTotalAggr_", yr, " is not PFHR.Aggr + FHCLAggr.")
}
cat("Aggregates: each is the sum of its components in both vintages.\n\n")

if (anyDuplicated(fHouse$Country.Code))
  stop("Country.Code is not unique. Nothing was written.")

# ------------------------------------------- per-variable report

## Everything R/data-fHouse.R has to state. Read the numbers off this rather
## than deriving them by hand.
cat("Every variable -- class, missing count, observed range:\n")
for (v in names(fHouse)) {
  x <- fHouse[[v]]
  rng <- if (is.numeric(x) && any(!is.na(x))) {
    r <- range(x, na.rm = TRUE)
    sprintf("%.2f to %.2f", r[1], r[2])
  } else if (is.factor(x)) {
    paste(nlevels(x), "levels:", paste(levels(x), collapse = " | "))
  } else ""
  cat(sprintf("  %-24s %-9s NA: %4d   %s\n",
              v, class(x)[1], sum(is.na(x)), rng))
}
cat("\n")

for (yr in FH_YEARS) {
  cat("FHStatus_", yr, ":\n", sep = "")
  print(table(fHouse[[paste0("FHStatus_f_", yr)]], useNA = "ifany"))
  cat("\n")
}

# --------------------------------------------------------------- back up

target <- file.path("data", "fHouse.RData")
if (file.exists(target)) {
  backup <- paste0(target, ".bak")
  if (file.exists(backup)) {
    cat("NOTE: a backup already exists at", backup, "-- leaving it as it is.\n")
    cat("      It predates this run.\n\n")
  } else {
    file.copy(target, backup)
    cat("Backed up existing", target, "to", backup, "\n\n")
  }
}

# ------------------------------------------------------------------- write

fHouse <- as.data.frame(fHouse)
save(fHouse, file = target, compress = "xz")

cat("Wrote ", target, " -- ", nrow(fHouse), " rows, ",
    ncol(fHouse), " variables.\n\n", sep = "")

# ---------------------------------------------------------------------------
# AFTER RUNNING THIS
# ---------------------------------------------------------------------------
#
# Restart R before reading fHouse back. The package holds the old object in
# its lazy-load database for the rest of the session.
#
# Then, with the package reinstalled:
#
#     data("fHouse", package = "QPATutorialsCourse")
#     names(fHouse)
#     table(fHouse$FHStatus_f_2022, useNA = "ifany")
#
# STILL TO DO, and neither is optional:
#
#   R/data-fHouse.R must be rewritten from the per-variable report above. The
#   old codebook describes an object that no longer exists -- W5Country,
#   FHStatus_raw, the unsuffixed aggregates, all gone.
##
#   T15's Example 2 moves to FHTotalAggr_2016 and needs its coefficients
#   re-derived. Its n drops from 81 countries to however many have both a 2016
#   score and a Wave 7 survey.
#
#   tools/rebuild-fHouse.R is now obsolete -- it operates on the old structure
#   (FHStatus_raw, the dropped X column) and none of it exists here. Delete it
#   rather than leaving it in tools/ as a trap.
# ---------------------------------------------------------------------------
