#' Cross-National Political, Economic, and Social Indicators
#'
#' A cross-sectional dataset with political, economic, demographic, and social
#' indicators for countries and territories around the world. The dataset was
#' originally distributed with the `poliscidata` package for use with
#' \emph{R Companion to Essentials of Political Analysis, Second Edition}.
#'
#' The complete dataset contains 167 observations and 103 variables. The
#' variables described below are a selected subset. Consult the poliscidata
#' package documentation for definitions of the remaining variables.
#'
#' @format A data frame with 167 rows and 103 variables.
#'
#' @details
#' The variables described here are:
#'
#' \describe{
#'
#'   \item{country}{
#'     Country or territory name.
#'     Stored as a factor.
#'     Missing values: 0.
#'   }
#'
#'   \item{dem_level4}{
#'     Regime type from the Economist Intelligence Unit's 2014 classification.
#'     Categories are `"Full Democ"`, `"Part Democ"`, `"Hybrid"`, and
#'     `"Authoritarian"`.
#'     Stored as a factor.
#'     Missing values: 0.
#'   }
#'
#'   \item{fertility}{
#'     Total fertility rate, measured as the average number of children born
#'     per woman.
#'     Observed range: 1.07--7.60.
#'     Missing values: 2.
#'   }
#'
#'   \item{spendeduc}{
#'     Public expenditure on education as a percentage of gross domestic
#'     product.
#'     Observed range: 0.6--13.6.
#'     Missing values: 17.
#'   }
#'
#'   \item{lifeex_total}{
#'     Life expectancy at birth for the total population, in years.
#'     Observed range: 38.76--82.25.
#'     Missing values: 2.
#'   }
#'
#'   \item{confidence}{
#'     Confidence in institutions scale from the World Values Survey.
#'     Higher values indicate greater confidence.
#'     Theoretical range: 0--100. Observed range: approximately 6.49--99.86.
#'     Missing values: 99.
#'   }
#'
#'   \item{durable}{
#'     Number of years since the country's most recent regime transition,
#'     from the Polity data.
#'     Observed range: 0--191.
#'     Missing values: 19.
#'   }
#'
#'   \item{effectiveness}{
#'     Government effectiveness scale based on Kaufmann (2002). Higher values
#'     indicate greater government effectiveness.
#'     Theoretical range: 0--100. Observed range: approximately 7.80--100.
#'     Missing values: 14.
#'   }
#'
#'   \item{gdppcap08}{
#'     Gross domestic product per capita in U.S. dollars in 2008.
#'     Observed range: 188--85,868.
#'     Missing values: 15.
#'   }
#'
#'   \item{gender_equal3}{
#'     Gender empowerment measure grouped into three categories:
#'     `"Low"`, `"Medium"`, and `"High"`.
#'     Stored as a factor.
#'     Missing values: 95.
#'   }
#'
#'   \item{gini04}{
#'     Income Gini coefficient from the United Nations for 2004. Higher values
#'     indicate greater income inequality.
#'     Theoretical range: 0--100. Observed range: 24.4--70.7.
#'     Missing values: 46.
#'   }
#'
#'   \item{gini08}{
#'     Income Gini coefficient from the United Nations for 2008. Higher values
#'     indicate greater income inequality.
#'     Theoretical range: 0--100. Observed range: 24.7--74.3.
#'     Missing values: 45.
#'   }
#'
#'   \item{regime_type3}{
#'     Regime type from Cheibub's Democracy and Dictatorship dataset.
#'     Categories are `"Dictatorship"`, `"Parliamentary democ"`, and
#'     `"Presidential democ"`.
#'     Stored as a factor.
#'     Missing values: 34.
#'   }
#'
#'   \item{unions}{
#'     Union density, measured as the percentage of workers who belong to a
#'     labor union.
#'     Theoretical range: 0--100. Observed range: 2.0--96.1.
#'     Missing values: 78.
#'   }
#' }
#'
#' Sources vary by variable. The original `poliscidata` documentation directs
#' users to Appendix Table A.4 of the printed textbook for complete source
#' information.
#'
#' The dataset includes countries and territories rather than only sovereign
#' states. Missingness varies considerably across variables because the
#' original indicators come from different source organizations and years.
#'
#' @source
#' `poliscidata` package, `world` dataset. Originally prepared for
#' \emph{R Companion to Essentials of Political Analysis, Second Edition}.
#'
#' Variable sources identified in the original documentation include:
#' \itemize{
#'   \item `confidence`: World Values Survey.
#'   \item `dem_level4`: Economist Intelligence Unit, 2014.
#'   \item `fertility` and `lifeex_total`: CIA.
#'   \item `spendeduc`, `gini04`, and `gini08`: United Nations.
#'   \item `durable`: Polity.
#'   \item `effectiveness`: Kaufmann (2002).
#'   \item `gdppcap08`: World Bank.
#'   \item `gender_equal3`: World Values Survey.
#'   \item `regime_type3`: Cheibub's Democracy and Dictatorship dataset.
#'   \item `unions`: International Labour Organization.
#' }
#'
#' @keywords datasets
#'
"world"
