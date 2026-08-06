#' Quality of Government Basic Cross-Section Dataset
#'
#' A cross-national dataset containing measures of political institutions,
#' governance, economic conditions, social conditions, and other country
#' characteristics. This object is based on the January 2020 cross-section
#' version of the Quality of Government Basic Dataset
#' (`QoGBasCSJan20`).
#'
#' The complete dataset contains 194 observations and 373 variables compiled
#' from numerous original sources. The variables described below are the
#' country identifiers and a selected subset of the substantive variables.
#' Consult the
#' official Quality of Government Basic Dataset January 2020 codebook for
#' definitions of the remaining variables.
#'
#' @format A data frame with 194 rows and 373 variables.
#'
#' @details
#' The principal identifiers and the variables used in the QPATutorialsCourse
#' tutorials are:
#'
#' \describe{
#'
#'   \item{ccode}{
#'     Quality of Government numeric country code.
#'     Missing values: 0.
#'   }
#'
#'   \item{cname}{
#'     Country or territory name.
#'     Missing values: 0.
#'   }
#'
#'   \item{ccodealp}{
#'     Three-letter country code.
#'     Missing values: 0.
#'   }
#'
#'   \item{bti_eo}{
#'     Equal opportunity score from the Bertelsmann Transformation Index.
#'     The measure evaluates the extent to which women and members of ethnic,
#'     religious, and other groups have equal access to education, public
#'     office, and employment. Higher values indicate greater equality of
#'     opportunity. Observed values range from 1 to 9.
#'     Missing values: 58.
#'   }
#'
#'   \item{epi_epi}{
#'     Environmental Performance Index. A composite measure of country
#'     performance on environmental health and ecosystem vitality, scaled from
#'     0 to 100, with higher values indicating better environmental
#'     performance. Observed values range from 27.43 to 87.42.
#'     Missing values: 14.
#'   }
#'
#'   \item{fh_ipolity2}{
#'     Level of democracy based on combined Freedom House and Polity
#'     information, scaled from 0 to 10. Higher values indicate a higher level
#'     of democracy. Missing Polity values were imputed using Freedom House
#'     information. Observed values range from 0 to 10.
#'     Missing values: 0.
#'   }
#'
#'   \item{fh_pr}{
#'     Freedom House political rights rating. The measure evaluates citizens'
#'     ability to participate freely in the political process, including
#'     electoral choice, political competition, political organization, and
#'     accountable representation. Values range from 1, indicating the
#'     greatest political rights, to 7, indicating the fewest political rights.
#'     Missing values: 0.
#'   }
#'
#'   \item{fh_rol}{
#'     Freedom House rule-of-law score. The measure covers judicial
#'     independence, the application of law in civil and criminal matters,
#'     civilian control of police, protection from political violence and
#'     unjustified punishment, and equal treatment under the law. Values range
#'     from 0 to 16, with higher values indicating stronger rule of law.
#'     Missing values: 0.
#'   }
#'
#'   \item{hf_efiscore}{
#'     Heritage Foundation Economic Freedom Index. The index combines measures
#'     of business, trade, fiscal, monetary, investment, financial, property,
#'     labor, government-spending, and corruption-related freedoms. The
#'     theoretical scale ranges from 0 to 100, with higher values indicating
#'     greater economic freedom. Observed values range from 2.3 to 87.8.
#'     Missing values: 17.
#'   }
#'
#'   \item{ipi_tradeopen}{
#'     Trade-openness component of the Index of Public Integrity. The measure
#'     combines standardized information about the documents and time required
#'     to export and import. Values range from 1 to 10, with higher values
#'     indicating greater trade openness.
#'     Missing values: 78.
#'   }
#'
#'   \item{ipu_l_sw}{
#'     Share of women in the lower or single house of the national legislature,
#'     from the Inter-Parliamentary Union. Records the percentage of seats held
#'     by women in a country's lower house, or in its single chamber where the
#'     parliament is unicameral.
#'     Theoretical range: 0--100. Observed range: 0.0--63.8.
#'     Missing values: 1.
#'   }
#'
#'   \item{vdem_polyarchy}{
#'     V-Dem Electoral Democracy Index. The index measures the extent to which
#'     rulers are responsive to citizens through broad suffrage, clean and
#'     competitive elections, freedom of association, freedom of expression,
#'     independent media, and elected officials with effective authority.
#'     Higher values indicate greater electoral democracy. Observed values
#'     range from 0.022 to 0.933.
#'     Missing values: 21.
#'   }
#'
#'   \item{wbgi_cce}{
#'     Control of corruption estimate from the World Bank's Worldwide
#'     Governance Indicators. Captures perceptions of the extent to which
#'     public power is exercised for private gain, including both petty and
#'     grand forms of corruption and the capture of the state by elites and
#'     private interests. Higher values indicate better control of corruption.
#'     Theoretical range: approximately -2.5--2.5. Observed range:
#'     -2.35--2.21.
#'     Missing values: 2.
#'   }
#'
#'   \item{wdi_fertility}{
#'     Total fertility rate from the World Bank's World Development Indicators,
#'     measured as the expected number of births per woman under the
#'     age-specific fertility rates prevailing in the reference year.
#'     Observed values range from 1.172 to 7.087.
#'     Missing values: 9.
#'   }
#'
#'   \item{wdi_gini}{
#'     Gini index of income or consumption inequality from the World Bank's
#'     World Development Indicators. A value of 0 represents perfect equality
#'     and a value of 100 represents perfect inequality. Observed values range
#'     from 25 to 63.
#'     Missing values: 80.
#'   }
#' }
#'
#' The Quality of Government Basic Dataset is a compilation dataset. Variables
#' come from different original sources and may refer to different years. In
#' the cross-section dataset, the most recent observation available within the
#' source-specific selection window is generally used. Users should therefore
#' not assume that every variable was measured in 2020.
#'
#' Variable prefixes identify the original data source. For example, `bti_`
#' denotes the Bertelsmann Transformation Index, `fh_` denotes Freedom House,
#' `vdem_` denotes Varieties of Democracy, and `wdi_` denotes World Development
#' Indicators.
#'
#' @source
#' Quality of Government Institute, University of Gothenburg. Quality of
#' Government Basic Dataset, cross-section, version January 2020. Individual
#' variables remain attributable to their original data providers; consult the
#' official January 2020 codebook for source-specific citations.
#'
#' @references
#' Dahlberg, Stefan, Sören Holmberg, Bo Rothstein, Natalia Alvarado Pachon,
#' and Sofia Axelsson. 2020. The Quality of Government Basic Dataset,
#' version January 2020. University of Gothenburg: Quality of Government
#' Institute.
#'
#' @keywords datasets
#'
"qog"
