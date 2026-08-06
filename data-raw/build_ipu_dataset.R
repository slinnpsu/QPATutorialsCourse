# Build the IPU package dataset from a fixed raw snapshot
# Source: IPU Parline API
# Snapshot date: 2026-08-05
#
# Run this script from the package root.
# On 2026-08-05, the first run downloads and saves the raw API snapshot.
# Later runs load that snapshot and reproduce the same package dataset.

library(httr2)
library(purrr)
library(dplyr)
library(tidyr)
library(tibble)

snapshot_date <- as.Date("2026-08-05")
snapshot_year <- as.integer(format(snapshot_date, "%Y"))
snapshot_file <- file.path("data-raw", "ipu_raw_2026-08-05.RData")
output_file <- file.path("data", "ipu.RData")

# Helper functions --------------------------------------------------------------

get_ipu_page <- function(endpoint, page_number, page_size = 100) {
  request(endpoint) |>
    req_url_query(
      `page[number]` = page_number,
      `page[size]` = page_size
    ) |>
    req_perform() |>
    resp_body_json(simplifyVector = FALSE)
}

get_all_ipu_records <- function(endpoint, page_size = 100) {
  first_page <- get_ipu_page(endpoint, 1, page_size)
  total_records <- first_page$meta$total
  total_pages <- ceiling(total_records / page_size)

  pages <- c(
    list(first_page),
    if (total_pages > 1) {
      purrr::map(
        2:total_pages,
        ~ get_ipu_page(endpoint, .x, page_size)
      )
    } else {
      list()
    }
  )

  pages |>
    purrr::map("data") |>
    purrr::list_flatten()
}

current_entry <- function(x) {
  if (is.null(x) || length(x) == 0) {
    return(NULL)
  }

  if (!is.null(x$value)) {
    return(x)
  }

  open_entry <- purrr::keep(
    x,
    ~ is.null(.x$date_to) || identical(.x$date_to, "")
  )

  if (length(open_entry) > 0) {
    return(open_entry[[length(open_entry)]])
  }

  x[[length(x)]]
}

extract_value <- function(x) {
  entry <- current_entry(x)

  if (is.null(entry) || is.null(entry$value)) {
    return(NA)
  }

  value <- entry$value

  if (is.list(value) && !is.null(value$term)) {
    return(value$term)
  }

  if (is.list(value) && !is.null(value$en)) {
    return(value$en)
  }

  value
}

extract_direct <- function(x) {
  if (is.null(x) || is.null(x$value)) {
    return(NA)
  }

  x$value
}

extract_year <- function(x) {
  if (is.null(x) || length(x) == 0 || is.na(x) || identical(x, "")) {
    return(NA_integer_)
  }

  as.integer(substr(x, 1, 4))
}

extract_collection_year <- function(x, field) {
  if (is.null(x) || is.null(x$value) || length(x$value) == 0) {
    return(NA_integer_)
  }

  national <- purrr::keep(
    x$value,
    function(entry) {
      !is.null(entry$national_or_local$term) &&
        entry$national_or_local$term == "national"
    }
  )

  entries <- if (length(national) > 0) national else x$value

  dates <- purrr::map_chr(
    entries,
    function(entry) {
      value <- entry[[field]]
      if (is.null(value)) NA_character_ else value
    }
  )

  years <- suppressWarnings(as.integer(substr(dates, 1, 4)))

  if (all(is.na(years))) {
    NA_integer_
  } else {
    min(years, na.rm = TRUE)
  }
}

# Stage 1: create or load the fixed raw snapshot --------------------------------

if (!file.exists(snapshot_file)) {
  if (Sys.Date() != snapshot_date) {
    stop(
      "The fixed 2026-08-05 raw snapshot is missing. ",
      "Do not download current API data under the old snapshot date."
    )
  }

  chambers_raw <- get_all_ipu_records(
    "https://api.data.ipu.org/v1/chambers"
  )

  countries_raw <- get_all_ipu_records(
    "https://api.data.ipu.org/v1/countries"
  )

  parliaments_raw <- get_all_ipu_records(
    "https://api.data.ipu.org/v1/parliaments"
  )

  elections_raw <- get_all_ipu_records(
    "https://api.data.ipu.org/v1/elections"
  )

  save(
    chambers_raw,
    countries_raw,
    parliaments_raw,
    elections_raw,
    snapshot_date,
    file = snapshot_file
  )
} else {
  load(snapshot_file)
}

# Stage 2: build the package dataset from the snapshot --------------------------

lower_chambers <- chambers_raw |>
  purrr::keep(~ grepl("-LC", .x$id)) |>
  purrr::map_dfr(function(x) {
    a <- x$attributes

    tibble::tibble(
      chamber_id = x$id,
      country_code = extract_value(a$parliament),
      chamber_name = extract_value(a$chamber_name),
      members = as.numeric(extract_value(a$current_members_number)),
      women = as.numeric(extract_value(a$current_women_number)),
      women_percent = as.numeric(extract_value(a$current_women_percent)),
      electoral_system = extract_value(a$electoral_system),
      gender_quota = as.logical(extract_value(a$is_electoral_quota_women)),
      reserved_seats = as.logical(extract_value(a$is_reserved_seats)),
      gender_quota_or_reserved =
        as.logical(extract_value(a$gender_quota_or_reserved_seats)),
      minimum_voting_age =
        as.numeric(extract_value(a$min_age_vote_elect)),
      suspended =
        as.logical(extract_value(a$is_suspended_chamber))
    )
  })

countries <- countries_raw |>
  purrr::map_dfr(function(x) {
    a <- x$attributes

    tibble::tibble(
      country_code = extract_value(a$country_code),
      country_name = extract_value(a$country_name_current),
      political_system = extract_value(a$political_system),
      political_subsystem = extract_value(a$political_subsystem),
      region = extract_value(a$region),
      subregion = extract_value(a$subregion)
    )
  })

parliaments <- parliaments_raw |>
  purrr::map_dfr(function(x) {
    a <- x$attributes

    tibble::tibble(
      country_code = extract_value(a$parliament_country),
      compulsory_voting = extract_value(a$compulsory_voting),
      parliament_structure = extract_value(a$structure_of_parliament),
      first_woman_in_parliament_year =
        extract_year(extract_value(a$first_woman_in_parliament_year)),
      women_vote_year =
        extract_collection_year(a$suffrage, "right_to_vote"),
      women_stand_year =
        extract_collection_year(
          a$women_stand_for_election,
          "women_stand_for_election_year"
        ),
      parliament_suspended =
        as.logical(extract_value(a$is_suspended_parliament))
    )
  })

elections <- elections_raw |>
  purrr::keep(~ grepl("-LC", .x$attributes$chamber$value)) |>
  purrr::map_dfr(function(x) {
    a <- x$attributes
    election_date <- a$election_date$value$from

    tibble::tibble(
      election_id = x$id,
      chamber_id = extract_direct(a$chamber),
      country_code = substr(extract_direct(a$chamber), 1, 2),
      election_date = as.Date(substr(election_date, 1, 10)),
      election_year = as.integer(substr(election_date, 1, 4)),
      alternation_of_power =
        as.logical(extract_direct(a$alter_power_after_election)),
      parties_winning_seats =
        as.numeric(extract_direct(a$num_parties_winning_seats)),
      parties_in_government =
        as.numeric(extract_direct(a$num_parties_in_government)),
      seats_at_stake =
        as.numeric(extract_direct(a$number_of_seats_at_stake)),
      total_candidates =
        as.numeric(extract_direct(a$total_num_candidates)),
      women_candidates =
        as.numeric(extract_direct(a$num_women_candidates)),
      women_candidates_percent =
        as.numeric(extract_direct(a$percent_women_candidates)),
      women_elected =
        as.numeric(extract_direct(a$num_women_elected)),
      women_elected_percent =
        as.numeric(extract_direct(a$percentage_women_elected)),
      women_after_election =
        as.numeric(extract_direct(a$num_women_after_election)),
      women_after_election_percent =
        as.numeric(extract_direct(a$per_women_after_election)),
      largest_party_seat_percent =
        as.numeric(extract_direct(a$largest_party_seat_percent))
    )
  }) |>
  arrange(country_code, desc(election_date)) |>
  group_by(country_code) |>
  slice(1) |>
  ungroup()

ipu_full <- lower_chambers %>%
  left_join(countries, by = "country_code") %>%
  left_join(parliaments, by = "country_code") %>%
  left_join(elections, by = c("country_code", "chamber_id")) |>
  mutate(
    largest_party_seat_percent = if_else(
      largest_party_seat_percent > 100,
      NA_real_,
      largest_party_seat_percent
    ),
    women_percent = if_else(
      is.na(women) & women_percent == 0,
      NA_real_,
      women_percent
    ),
    electoral_system_3 = na_if(electoral_system, "other_systems"),
    political_system_4 = case_when(
      political_system %in% c(
        "parliamentary_system",
        "presidential_system",
        "presidential_parliamentary"
      ) ~ political_system,
      TRUE ~ "other"
    )
  )

# Categorical variables remain character or logical so students can create
# factor versions themselves.

ipu <- ipu_full |>
  transmute(
    country = country_name,
    country_code,
    region,
    subregion,
    women_percent,
    women_members = women,
    total_members = members,
    electoral_system = electoral_system_3,
    gender_quota,
    reserved_seats,
    political_system = political_system_4,
    parliament_structure,
    compulsory_voting,
    minimum_voting_age,
    first_woman_year = first_woman_in_parliament_year,
    women_vote_year,
    women_stand_year,
    election_year,
    parties_winning_seats,
    total_candidates,
    women_candidates_percent,
    largest_party_seat_percent
  ) |>
  mutate(
    years_since_first_woman = snapshot_year - first_woman_year,
    years_since_women_vote = snapshot_year - women_vote_year,
    years_since_women_stand = snapshot_year - women_stand_year,
    years_since_election = snapshot_year - election_year,
    log_total_members = log(total_members),
    log_total_candidates = log(total_candidates)
  )

# Validation -------------------------------------------------------------------

stopifnot(
  nrow(ipu) == 193,
  all(
    is.na(ipu$women_percent) |
      dplyr::between(ipu$women_percent, 0, 100)
  ),
  all(
    is.na(ipu$women_candidates_percent) |
      dplyr::between(ipu$women_candidates_percent, 0, 100)
  ),
  all(
    is.na(ipu$largest_party_seat_percent) |
      dplyr::between(ipu$largest_party_seat_percent, 0, 100)
  ),
  all(
    is.na(ipu$women_members) |
      is.na(ipu$total_members) |
      ipu$women_members <= ipu$total_members
  )
)

# Save the package dataset ------------------------------------------------------

save(ipu, file = output_file)

variable_summary <- tibble(
  variable = names(ipu),
  type = purrr::map_chr(ipu, ~ class(.x)[1]),
  missing = purrr::map_int(ipu, ~ sum(is.na(.x))),
  distinct_values = purrr::map_int(
    ipu,
    ~ dplyr::n_distinct(.x, na.rm = TRUE)
  )
)

print(variable_summary, n = Inf)
