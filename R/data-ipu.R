#' Women in National Parliaments
#'
#' A country-level dataset describing women's representation, electoral
#' institutions, political systems, and the most recent lower-house or
#' unicameral election recorded by the Inter-Parliamentary Union (IPU).
#'
#' The country universe is the 193 countries returned by the IPU Parline API
#' snapshot downloaded on August 5, 2026. Each row represents the lower house
#' of a bicameral parliament or the single chamber of a unicameral parliament.
#'
#' Current parliamentary variables reflect the information available from the
#' IPU on August 5, 2026. Election variables refer to the most recent lower-house
#' or unicameral election recorded for each country as of that date, so election
#' years differ across countries.
#'
#' Electoral-system categories recorded by the IPU as \code{"other_systems"}
#' are set to missing in \code{electoral_system} because those cases do not form
#' a substantively coherent fourth category. The three retained categories are
#' proportional representation, plurality/majority, and mixed systems.
#'
#' Political systems are grouped into four categories. Parliamentary,
#' presidential, and presidential-parliamentary systems retain their original
#' IPU classifications; monarchy, communist, and transitional systems are
#' combined as \code{"other"}.
#'
#' Character and logical variables are deliberately not stored as factors so
#' that students can practice creating and labeling factor versions.
#'
#' @format A data frame with 193 rows and 28 variables:
#' \describe{
#'   \item{country}{Country name. Missing values: 0.}
#'   \item{country_code}{Two-letter country code used by the IPU. Missing values: 0.}
#'   \item{region}{IPU world region. Values are \code{"americas"}, \code{"asia"},
#'     \code{"europe"}, \code{"middle_east_and_north_africa"}, \code{"pacific"},
#'     and \code{"sub_saharan_africa"}. Missing values: 0.}
#'   \item{subregion}{IPU geographic subregion. Missing values: 0.}
#'   \item{women_percent}{Percentage of current chamber members who are women.
#'     Theoretical range: 0--100. Observed range: 0--63.75. Missing values: 8.}
#'   \item{women_members}{Number of current chamber members who are women.
#'     Missing values: 11.}
#'   \item{total_members}{Total number of current chamber members.
#'     Observed range: 14--2977. Missing values: 6.}
#'   \item{electoral_system}{Electoral-system family. Values are
#'     \code{"proportional_representation"}, \code{"plurality_majority"}, and
#'     \code{"mixed_system"}. IPU cases classified as \code{"other_systems"}
#'     are set to missing. There are 77 proportional-representation systems,
#'     65 plurality/majority systems, 36 mixed systems, and 15 missing values.}
#'   \item{gender_quota}{Logical indicator equal to \code{TRUE} when an electoral
#'     quota for women is reported and \code{FALSE} otherwise. There are
#'     115 \code{TRUE}, 77 \code{FALSE}, and 1 missing value.}
#'   \item{reserved_seats}{Logical indicator equal to \code{TRUE} when seats are
#'     reserved for women and \code{FALSE} otherwise. There are 47 \code{TRUE},
#'     143 \code{FALSE}, and 3 missing values.}
#'   \item{political_system}{Broad political-system category. Values are
#'     \code{"parliamentary_system"}, \code{"presidential_system"},
#'     \code{"presidential_parliamentary"}, and \code{"other"}. There are
#'     77 parliamentary systems, 47 presidential systems,
#'     41 presidential-parliamentary systems, and 28 other systems.
#'     Missing values: 0.}
#'   \item{parliament_structure}{Whether the national parliament is unicameral
#'     or bicameral. There are 108 unicameral and 85 bicameral systems.
#'     Missing values: 0.}
#'   \item{compulsory_voting}{IPU classification of compulsory voting. Values are
#'     \code{"yes"}, \code{"no"}, and \code{"yes_only_for_certain_people"}.
#'     There are 20 yes, 162 no, 4 yes only for certain people, and 7 missing values.}
#'   \item{minimum_voting_age}{Minimum voting age for national parliamentary
#'     elections. Observed range: 15--25. Missing values: 5.}
#'   \item{first_woman_year}{Year in which the first woman entered the national
#'     parliament. Observed range: 1907--2021. Missing values: 0.}
#'   \item{women_vote_year}{Earliest year recorded by the IPU in which women had
#'     the right to vote in national elections. Observed range: 1893--2006.
#'     Missing values: 20.}
#'   \item{women_stand_year}{Earliest year recorded by the IPU in which women
#'     could stand as candidates in national elections. Observed range: 1788--2006.
#'     Missing values: 25.}
#'   \item{election_year}{Year of the most recent lower-house or unicameral
#'     election recorded by the IPU as of August 5, 2026. Observed range:
#'     1994--2026. Missing values: 0.}
#'   \item{parties_winning_seats}{Number of political parties winning at least one
#'     seat in the most recent election. Observed range: 1--35.
#'     Missing values: 85.}
#'   \item{total_candidates}{Total number of candidates in the most recent
#'     election. Observed range: 19--10630. Missing values: 102.}
#'   \item{women_candidates_percent}{Percentage of candidates in the most recent
#'     election who were women. Theoretical range: 0--100. Observed range:
#'     1.04--55.32. Missing values: 114.}
#'   \item{largest_party_seat_percent}{Percentage of chamber seats won by the
#'     largest party in the most recent election. One impossible source value
#'     above 100 was set to missing. Theoretical range: 0--100. Observed range:
#'     0--100. Missing values: 43.}
#'   \item{years_since_first_woman}{Number of years from 2026 to
#'     \code{first_woman_year}, calculated as \code{2026 - first_woman_year}.
#'     Observed range: 5--119. Missing values: 0.}
#'   \item{years_since_women_vote}{Number of years from 2026 to
#'     \code{women_vote_year}, calculated as \code{2026 - women_vote_year}.
#'     Observed range: 20--133. Missing values: 20.}
#'   \item{years_since_women_stand}{Number of years from 2026 to
#'     \code{women_stand_year}, calculated as \code{2026 - women_stand_year}.
#'     Observed range: 20--238. Missing values: 25.}
#'   \item{years_since_election}{Number of years from 2026 to
#'     \code{election_year}, calculated as \code{2026 - election_year}.
#'     Observed range: 0--32. Missing values: 0.}
#'   \item{log_total_members}{Natural logarithm of \code{total_members}.
#'     Observed range: 2.64--8.00. Missing values: 6.}
#'   \item{log_total_candidates}{Natural logarithm of \code{total_candidates}.
#'     Observed range: 2.94--9.27. Missing values: 102.}
#' }
#'
#' @source
#' Inter-Parliamentary Union, Parline API. Snapshot downloaded August 5, 2026.
#' Current chamber variables reflect the information available from the IPU on
#' that date; election variables refer to the most recent election recorded for
#' each country as of that date.
#'
#' @keywords datasets
#'
"ipu"
