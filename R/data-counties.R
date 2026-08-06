#' U.S. County Election Returns, Economic Conditions, and Mortality Risk, 2016
#'
#' A cross-sectional data frame containing political, economic, demographic,
#' health, and rural-urban characteristics for U.S. counties in 2016.
#'
#' Compiled by Suzanna Linn, Jonathan Nagler, and Jan Zilinsky as the 2016
#' cross-section of a county-level panel beginning in 1972. The panel was
#' assembled to model incumbent-party vote share from the standard predictors
#' of an election model together with county mortality risk. It is unpublished.
#'
#' Several measures are included in both proportion and percentage-point form.
#' Variables ending in `_percent`, along with `wage_growth`,
#' `employ_pop_ratio_25_64`, and `employ_pop_ratio_25_64_change`,
#' are scaled for easier interpretation in the tutorials.
#'
#' @format A data frame with 3,112 rows and 37 variables:
#' \describe{
#'
#'   \item{fips_code}{
#'     Five-digit Federal Information Processing Standards (FIPS) county code.
#'     Missing values: 0.
#'   }
#'
#'   \item{year}{
#'     Observation year. All observations are from 2016.
#'     Missing values: 0.
#'   }
#'
#'   \item{state_name}{
#'     Full name of the state in which the county is located.
#'     Missing values: 0.
#'   }
#'
#'   \item{county_name}{
#'     County name.
#'     Missing values: 0.
#'   }
#'
#'   \item{state_abb}{
#'     Two-letter state abbreviation.
#'     Missing values: 0.
#'   }
#'
#'   \item{dem2p_vote_share}{
#'     Democratic share of the two-party presidential vote in 2016,
#'     expressed as a proportion from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 0.
#'   }
#'
#'   \item{rep2p_vote_share}{
#'     Republican share of the two-party presidential vote in 2016,
#'     expressed as a proportion from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 0.
#'   }
#'
#'   \item{avg_wkly_wage}{
#'     Average nominal weekly wage in the third quarter of 2016, in dollars,
#'     for jobs covered by the Quarterly Census of Employment and Wages.
#'     Missing values: 1.
#'   }
#'
#'   \item{wage_growth_prop}{
#'     Proportional change in average weekly wages from the third quarter of
#'     2015 to the third quarter of 2016. For example, 0.03 represents growth
#'     of 3 percent.
#'     Missing values: 2.
#'   }
#'
#'   \item{prop_over_65}{
#'     Proportion of the county population age 65 or older, from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 1.
#'   }
#'
#'   \item{rural_urban}{
#'     USDA 2013 Rural-Urban Continuum Code. Values range from 1 to 9, with
#'     smaller values indicating more urban counties and larger values
#'     indicating more rural counties. Codes 1--3 are metropolitan counties,
#'     distinguished by the population of the metro area they belong to;
#'     codes 4--9 are nonmetropolitan, distinguished by the size of the
#'     county's own urban population and by whether the county is adjacent
#'     to a metro area:
#'     \itemize{
#'       \item{1: metro county in a metro area of 1 million population or more}
#'       \item{2: metro county in a metro area of 250,000 to 1 million population}
#'       \item{3: metro county in a metro area of fewer than 250,000 population}
#'       \item{4: urban population of 20,000 or more, adjacent to a metro area}
#'       \item{5: urban population of 20,000 or more, not adjacent to a metro area}
#'       \item{6: urban population of 2,500 to 19,999, adjacent to a metro area}
#'       \item{7: urban population of 2,500 to 19,999, not adjacent to a metro area}
#'       \item{8: completely rural or urban population under 2,500, adjacent to a metro area}
#'       \item{9: completely rural or urban population under 2,500, not adjacent to a metro area}
#'     }
#'     Missing values: 0.
#'   }
#'
#'   \item{prop_college_grad}{
#'     Proportion of residents age 25 or older who have completed a bachelor's
#'     degree or higher, from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 1.
#'   }
#'
#'   \item{prop_foreignborn}{
#'     Proportion of county residents who were born outside the United States,
#'     from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 1.
#'   }
#'
#'   \item{prop_hispanic}{
#'     Proportion of county residents who are Hispanic or Latino, from 0 to 1.
#'     Hispanic origin may include people of any race.
#'     Theoretical range: 0--1.
#'     Missing values: 1.
#'   }
#'
#'   \item{prop_white}{
#'     Proportion of county residents classified as White, from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 1.
#'   }
#'
#'   \item{prop_black}{
#'     Proportion of county residents classified as Black, from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 2.
#'   }
#'
#'   \item{employ_pop_ratio_25_64_raw}{
#'     Ratio of jobs located in the county to the county population age 25--64,
#'     expressed as a proportion. The numerator is annual average employment
#'     reported by the Quarterly Census of Employment and Wages.
#'
#'     This variable can exceed 1 because employment is measured by place of
#'     work rather than workers' place of residence, and because workers with
#'     multiple jobs may be counted more than once.
#'     Missing values: 2.
#'   }
#'
#'   \item{employ_pop_ratio_25_64_change_raw}{
#'     Change in the employment-to-population ratio for ages 25--64 from the
#'     third quarter of 2015 to the third quarter of 2016, expressed on the
#'     proportion scale. Positive values indicate an increase.
#'     Missing values: 3.
#'   }
#'
#'   \item{dem2p_vote_share_2012}{
#'     Democratic share of the county's two-party presidential vote in 2012,
#'     expressed as a proportion from 0 to 1.
#'     Theoretical range: 0--1.
#'     Missing values: 41.
#'   }
#'
#'   \item{inc2pvs_change}{
#'     Change in the incumbent party's two-party presidential vote share from
#'     2012 to 2016. Because the incumbent president in 2016 was a Democrat,
#'     this equals the 2016 Democratic two-party vote share minus the 2012
#'     Democratic two-party vote share.
#'     Missing values: 41.
#'   }
#'
#'   \item{mortality_risk_25_45}{
#'     Estimated percentage risk that a person who has reached age 25 will die
#'     before reaching age 45. The underlying county mortality series ends in
#'     2014 and was extrapolated to 2016.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{mortality_risk_25_45_change}{
#'     Change in estimated mortality risk for ages 25--45 from 2012 to 2016,
#'     measured in percentage points. Negative values indicate declining
#'     mortality risk.
#'     Missing values: 1.
#'   }
#'
#'   \item{TrumpMajority}{
#'     Indicator for the winner of the county's two-party presidential vote in
#'     2016: 0 if Hillary Clinton received a majority and 1 if Donald Trump
#'     received a majority.
#'     Missing values: 0.
#'   }
#'
#'   \item{Majority}{
#'     Factor version of `TrumpMajority`, with levels `"Clinton Majority"` and
#'     `"Trump Majority"`.
#'     Missing values: 0.
#'   }
#'
#'   \item{racial_majority}{
#'     Character variable identifying whether more than 50 percent of the
#'     county population is White, Black, or Hispanic. Values are
#'     `"White Majority"`, `"Black Majority"`, `"Hispanic Majority"`, and
#'     `"Other/No Majority"`.
#'     Missing values: 0.
#'   }
#'
#'   \item{majority_white}{
#'     Indicator for whether a county has a white majority: 1 for the counties
#'     `racial_majority` records as `"White Majority"`, 0 for the other three
#'     categories.
#'     This is not the same as `prop_white` exceeding 0.5. The Census counts
#'     White as a race and Hispanic as an ethnicity, so a county can be more
#'     than half White and more than half Hispanic at once; `racial_majority`
#'     assigns those 95 counties to `"Hispanic Majority"`, and they are coded 0
#'     here.
#'     Missing values: 0.
#'   }
#'
#'   \item{rural}{
#'     Three-category rural-urban measure derived from `rural_urban`:
#'     0 for codes 1--3, 1 for codes 4--7, and 2 for codes 8--9.
#'     These categories correspond to urban, intermediate, and rural counties,
#'     respectively. The cut points follow the USDA scheme documented under
#'     `rural_urban`: codes 1--3 are the metropolitan counties, codes 4--7 the
#'     nonmetropolitan counties with an urban population of at least 2,500,
#'     and codes 8--9 the counties that are completely rural or have an urban
#'     population under 2,500.
#'     Missing values: 0.
#'   }
#'
#'   \item{dem2p_percent}{
#'     Democratic share of the two-party presidential vote in 2016, expressed
#'     as a percentage from 0 to 100. Equal to
#'     `dem2p_vote_share * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 0.
#'   }
#'
#'   \item{Black_percent}{
#'     Percentage of county residents classified as Black. Equal to
#'     `prop_black * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 2.
#'   }
#'
#'   \item{white_percent}{
#'     Percentage of county residents classified as White. Equal to
#'     `prop_white * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{hispanic_percent}{
#'     Percentage of county residents who are Hispanic or Latino. Equal to
#'     `prop_hispanic * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{college_grad_percent}{
#'     Percentage of residents age 25 or older who have completed a bachelor's
#'     degree or higher. Equal to `prop_college_grad * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{over_65_percent}{
#'     Percentage of the county population age 65 or older. Equal to
#'     `prop_over_65 * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{foreignborn_percent}{
#'     Percentage of county residents who were born outside the United States.
#'     Equal to `prop_foreignborn * 100`.
#'     Theoretical range: 0--100.
#'     Missing values: 1.
#'   }
#'
#'   \item{wage_growth}{
#'     Percentage change in average weekly wages from the third quarter of 2015
#'     to the third quarter of 2016. Equal to `wage_growth_prop * 100`.
#'     Missing values: 2.
#'   }
#'
#'   \item{employ_pop_ratio_25_64}{
#'     Number of jobs located in the county per 100 county residents age 25--64.
#'     Equal to `employ_pop_ratio_25_64_raw * 100`. Values can exceed 100
#'     because employment is measured by place of work and may count multiple
#'     jobs held by the same person.
#'     Missing values: 2.
#'   }
#'
#'   \item{employ_pop_ratio_25_64_change}{
#'     Change from the third quarter of 2015 to the third quarter of 2016 in the
#'     number of jobs located in the county per 100 residents age 25--64.
#'     Equal to `employ_pop_ratio_25_64_change_raw * 100`.
#'     Missing values: 3.
#'   }
#' }
#'
#' @details
#' Election measures are based on county presidential election returns.
#' Wage and employment measures come from the U.S. Bureau of Labor Statistics
#' Quarterly Census of Employment and Wages. Population and demographic
#' measures are based on U.S. Census Bureau population estimates, the
#' decennial census, and American Community Survey data. Rural-urban
#' classifications use the USDA Economic Research Service 2013 Rural-Urban
#' Continuum Codes. Mortality-risk estimates are based on Institute for Health
#' Metrics and Evaluation county mortality estimates.
#'
#' The QCEW counts filled jobs by place of work rather than employed residents.
#' It excludes some categories of employment, including self-employed workers,
#' members of the Armed Forces, and some agricultural, railroad, domestic,
#' student, and nonprofit workers.
#'
#' @source
#' Compiled by Suzanna Linn, Jonathan Nagler, and Jan Zilinsky from the
#' following sources: county presidential election returns; U.S. Bureau of
#' Labor Statistics Quarterly Census of Employment and Wages; U.S. Census
#' Bureau; American Community Survey; USDA Economic Research Service; and
#' Institute for Health Metrics and Evaluation.
#'
#' @keywords datasets
#'
"counties"
