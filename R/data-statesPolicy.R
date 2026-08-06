#' Selected U.S. State Policy, Political, and Demographic Measures
#'
#' A state-level dataset containing selected political, policy, economic,
#' demographic, and religious measures for the 50 U.S. states and the
#' District of Columbia.
#'
#' @format A data frame with 51 rows and 26 variables:
#' \describe{
#'   \item{State}{
#'     Full state name or `"District of Columbia"`.
#'     Missing values: 0.
#'   }
#'   \item{ST}{
#'     Two-letter U.S. postal abbreviation, including `"DC"` for the
#'     District of Columbia.
#'     Missing values: 0.
#'   }
#'   \item{Region}{
#'     U.S. Census region: `"Northeast"`, `"Midwest"`,
#'     `"South"`, or `"West"`.
#'     Missing values: 1 (Maryland).
#'   }
#'   \item{South}{
#'     Whether the state is in the U.S. Census South region:
#'     `"Yes"` or `"No"`.
#'     Missing values: 0.
#'   }
#'   \item{policy_ghgcap2024}{
#'     Indicator that the state had a greenhouse-gas emissions cap in the
#'     utility sector as of 2024: 1 = cap and 0 = no cap.
#'     Missing values: 0.
#'   }
#'   \item{ideology_conservative2024}{
#'     Percentage of PRRI American Values Atlas respondents identifying as
#'     conservative in 2024.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{party_governor2024}{
#'     Party of the sitting governor in 2024: `"Democrat"` or
#'     `"Republican"` in this dataset.
#'     Missing values: 0.
#'   }
#'   \item{econ_poverty2022}{
#'     Percentage of the population below the federal poverty line in 2022,
#'     based on the American Community Survey.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{party_Republican2024}{
#'     Percentage of PRRI American Values Atlas respondents identifying as
#'     Republican in 2024. This is a survey measure, not the percentage of
#'     registered voters.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{party_Democrat2024}{
#'     Percentage of PRRI American Values Atlas respondents identifying as
#'     Democrat in 2024. This is a survey measure, not the percentage of
#'     registered voters.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{ideology_liberal2024}{
#'     Percentage of PRRI American Values Atlas respondents identifying as
#'     liberal in 2024.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{pop_white2022}{
#'     Percentage of the population identifying as non-Hispanic white alone
#'     in the 2022 American Community Survey.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{pop_black2022}{
#'     Percentage of the population identifying as non-Hispanic Black or
#'     African American alone in the 2022 American Community Survey.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{pop_hispanic2022}{
#'     Percentage of the population identifying as Hispanic or Latino of
#'     any race in the 2022 American Community Survey.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{pop_urban2020}{
#'     Percentage of the population living in urban areas according to the
#'     2020 Decennial Census definition of urban.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{econ_income2022}{
#'     Median household income in 2022, in nominal dollars, based on the
#'     American Community Survey.
#'     Missing values: 0.
#'   }
#'   \item{edu_college2022}{
#'     Percentage of adults age 25 or older with at least a bachelor's
#'     degree in the 2022 American Community Survey.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'   \item{pop_total2022}{
#'     Total state population in 2022, based on the American Community
#'     Survey.
#'     Missing values: 0.
#'   }
#'   \item{religion_WhiteEvanProtestant2024}{
#'     Percentage of PRRI American Values Atlas respondents identifying as
#'     White Evangelical Protestant in 2024. The District of Columbia is
#'     missing.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{religion_Unaffiliated2024}{
#'     Percentage of PRRI American Values Atlas respondents reporting no
#'     religious affiliation in 2024, including atheist, agnostic, and
#'     nothing in particular.
#'     Theoretical range: 0--100.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{policy_medicaidexpansion2024}{
#'     Indicator that the state had expanded Medicaid under the Affordable
#'     Care Act as of 2024, extending coverage to adults with incomes up to
#'     138 percent of the federal poverty level: 1 = expanded and
#'     0 = not expanded.
#'     Missing values: 0.
#'   }
#'   \item{policy_righttowork2024}{
#'     Indicator that the state had a right-to-work law as of 2024:
#'     1 = yes and 0 = no.
#'     Missing values: 0.
#'   }
#'   \item{policy_transgendersportsban2024}{
#'     Indicator that the state had a ban on transgender youth
#'     participating in sports consistent with their gender identity as of
#'     2024: 1 = ban and 0 = no ban.
#'     Missing values: 0.
#'   }
#'   \item{abortion_totalban2024}{
#'     Indicator that the state had a total or near-total abortion ban in
#'     effect as of 2024: 1 = yes and 0 = no. The District of Columbia is
#'     missing.
#'     Missing values: 1 (the District of Columbia).
#'   }
#'   \item{party_trifecta2024}{
#'     Party-control status following the 2024 elections:
#'     `"Republican"`, `"Democrat"`, or `"Divided"`.
#'     Nebraska is missing because its unicameral legislature is officially
#'     nonpartisan.
#'     Missing values: 1 (Nebraska).
#'   }
#'   \item{party_LegControl2024}{
#'     Overall legislative control following the 2024 elections:
#'     `"Republican"`, `"Democrat"`, `"Divided"`, or
#'     `"Nonpartisan"`.
#'     Missing values: 0.
#'   }
#' }
#'
#' @details
#' This dataset is a subset of the larger U.S. state-level class dataset
#' developed for PLSC 309H. Survey-based party, ideology, and religion
#' variables are percentages from the PRRI American Values Atlas and should
#' not be interpreted as voter-registration statistics. The year embedded
#' in each variable name indicates the data vintage.
#'
#' @source
#' U.S. Census Bureau, American Community Survey and 2020 Decennial Census;
#' PRRI American Values Atlas; National Conference of State Legislatures;
#' Center for Reproductive Rights; and the Caughey and Warshaw Dynamic
#' Democracy project. See the PLSC 309H U.S. State-Level Data codebook for
#' full source details.
#'
#' @keywords datasets
#'
"statesPolicy"
