# =====================================================================
# T17 -- WRONG ANSWERS FOR TESTING THE GRADERS
#
# Each block below is a deliberately wrong submission. Paste one into the
# exercise named in its heading, press Submit Answer, and compare what you
# get with the EXPECT line.
#
# These do NOT run as a script --- they are paste-one-at-a-time test cases,
# and several would error outside learnr. The correct answers are in
# T17-all-code.R; run one of those after each failure to confirm the
# exercise still passes.
#
# The cases are chosen to reach the checks added on 19 October, which read
# the finished plot rather than the text of the code. Each one passed before
# that change.
# =====================================================================


# ---------------------------------------------------------------------
# Practice 11: prediction plot for census region
# ---------------------------------------------------------------------

# CASE 1 -- axis labels swapped
# EXPECT: "Your axis labels are swapped."
plot_model(fit1,
           type = "pred",
           terms = "region_censusf",
           colors = cb_colors,
           title = "Predicted Democratic House Seat Share by Census Region",
           axis.title = c("Proportion of Democratic House Seats",
                          "Census Region")) +
  labs(caption = "Predictions are for states with average poverty rate, proportion liberal, and proportion non-white.")

# CASE 2 -- wrong variable on the x-axis; region_censusf is named, but held
#           rather than plotted
# EXPECT: "The plot should show one prediction for each of the four regions."
plot_model(fit1,
           type = "pred",
           terms = "p.liberal",
           condition = list(region_censusf = "South"),
           colors = cb_colors,
           title = "Predicted Democratic House Seat Share by Census Region",
           axis.title = c("Census Region",
                          "Proportion of Democratic House Seats")) +
  labs(caption = "Predictions are for states with average poverty rate, proportion liberal, and proportion non-white.")

# CASE 3 -- palette not set
# EXPECT: "Set `colors = cb_colors` so the plot uses the colorblind-safe palette."
plot_model(fit1,
           type = "pred",
           terms = "region_censusf",
           title = "Predicted Democratic House Seat Share by Census Region",
           axis.title = c("Census Region",
                          "Proportion of Democratic House Seats")) +
  labs(caption = "Predictions are for states with average poverty rate, proportion liberal, and proportion non-white.")


# ---------------------------------------------------------------------
# Apply 13: two-variable plot for liberalism and region
# ---------------------------------------------------------------------

# CASE 4 -- the two names in terms are the wrong way round
# EXPECT: "**p.liberal** belongs on the x-axis, with one line per region"
plot_model(fit1,
           type = "pred",
           terms = c("region_censusf", "p.liberal"),
           colors = cb_colors,
           title = "Predicted Democratic House Seat Share by Liberalism and Region",
           axis.title = c("Proportion Liberal",
                          "Proportion of Democratic House Seats"),
           legend.title = "Census Region") +
  labs(caption = "Predictions are for states with average poverty rate and proportion non-white.")

# CASE 5 -- legend title set with labs(color = ) instead of legend.title
# EXPECT: "Set the legend title with `legend.title =` inside `plot_model()`."
#         (this one is caught by a text check, before the plot is read)
plot_model(fit1,
           type = "pred",
           terms = c("p.liberal", "region_censusf"),
           colors = cb_colors,
           title = "Predicted Democratic House Seat Share by Liberalism and Region",
           axis.title = c("Proportion Liberal",
                          "Proportion of Democratic House Seats")) +
  labs(color = "Census Region",
       caption = "Predictions are for states with average poverty rate and proportion non-white.")


# ---------------------------------------------------------------------
# Practice 18: prediction plot for parliamentary history
# ---------------------------------------------------------------------

# CASE 6 -- axis labels swapped
# EXPECT: "Your axis labels are swapped."
plot_model(model_rep,
           type = "pred",
           terms = "years_c",
           colors = cb_colors,
           title = "Predicted Women's Representation by Length of Parliamentary History",
           axis.title = c("Predicted Percent Women",
                          "Years Since First Woman (centered)")) +
  labs(caption = "Predictions are for plurality/majority countries with no gender quota.")

# CASE 7 -- quota status on the x-axis instead of history; years_c is named,
#           but held rather than plotted
# EXPECT: "**years_c** belongs on the x-axis."
plot_model(model_rep,
           type = "pred",
           terms = "quota_f",
           condition = list(years_c = 0),
           colors = cb_colors,
           title = "Predicted Women's Representation by Length of Parliamentary History",
           axis.title = c("Years Since First Woman (centered)",
                          "Predicted Percent Women")) +
  labs(caption = "Predictions are for plurality/majority countries with no gender quota.")


# ---------------------------------------------------------------------
# Practice 20: prediction plot for electoral system
# ---------------------------------------------------------------------

# CASE 8 -- no x-axis label at all. The old grader passed this, because the
#           prescribed title contains the words "Electoral System".
# EXPECT: "The plot's x-axis label should be \"Electoral System\"."
plot_model(model_rep,
           type = "pred",
           terms = "electoral_f",
           colors = cb_colors,
           title = "Predicted Women's Representation by Electoral System",
           axis.title = c("", "Predicted Percent Women")) +
  labs(caption = "Predictions are for countries with no gender quota and average parliamentary history.")

# CASE 9 -- history on the x-axis instead of electoral system
# EXPECT: "**electoral_f** belongs on the x-axis, with one point for each of its three levels."
plot_model(model_rep,
           type = "pred",
           terms = "years_c",
           condition = list(electoral_f = "Plurality/Majority"),
           colors = cb_colors,
           title = "Predicted Women's Representation by Electoral System",
           axis.title = c("Electoral System",
                          "Predicted Percent Women")) +
  labs(caption = "Predictions are for countries with no gender quota and average parliamentary history.")


# ---------------------------------------------------------------------
# Apply 24: two-variable plot for history and electoral system
# ---------------------------------------------------------------------

# CASE 10 -- the two names in terms are the wrong way round
# EXPECT: "**years_c** belongs on the x-axis, with one line per electoral system"
plot_model(model_rep,
           type = "pred",
           terms = c("electoral_f", "years_c"),
           colors = cb_colors,
           title = "Predicted Women's Representation by History and Electoral System",
           axis.title = c("Years Since First Woman (centered)",
                          "Predicted Percent Women"),
           legend.title = "Electoral System") +
  labs(caption = "Predictions are for countries with no gender quota.")

# CASE 11 -- legend title never set. The text check is satisfied by the title,
#           which also contains "Electoral System".
# EXPECT: "The legend title should be \"Electoral System\"."
plot_model(model_rep,
           type = "pred",
           terms = c("years_c", "electoral_f"),
           colors = cb_colors,
           title = "Predicted Women's Representation by History and Electoral System",
           axis.title = c("Years Since First Woman (centered)",
                          "Predicted Percent Women")) +
  labs(caption = "Predictions are for countries with no gender quota.")


# ---------------------------------------------------------------------
# Practice 1: estimate the regression model
# ---------------------------------------------------------------------

# CASE 12 -- a predictor left out
# EXPECT: "Include povrate as a predictor."
fit1 <- lm(hs_dem_prop_all ~ nonwhite + p.liberal + region_censusf,
           data = states)
summary(fit1)

# CASE 13 -- the model saved but never displayed
# EXPECT: "The last line should display the summary."
fit1 <- lm(hs_dem_prop_all ~ nonwhite + p.liberal + povrate + region_censusf,
           data = states)


# ---------------------------------------------------------------------
# Apply 16: predicted percentages for two electoral systems
# ---------------------------------------------------------------------

# CASE 14 -- both calls use the same electoral system, so nothing is compared
# EXPECT: a failure naming call 2 and the profile it should describe
predict(model_rep,
        newdata = data.frame(
          quota_f     = factor("No quota", levels = levels(ipu$quota_f)),
          electoral_f = factor("Plurality/Majority", levels = levels(ipu$electoral_f)),
          years_c     = 0
        ))

predict(model_rep,
        newdata = data.frame(
          quota_f     = factor("No quota", levels = levels(ipu$quota_f)),
          electoral_f = factor("Plurality/Majority", levels = levels(ipu$electoral_f)),
          years_c     = 0
        ))

# CASE 15 -- right systems, wrong held value for history
# EXPECT: a failure naming the call whose profile is wrong
predict(model_rep,
        newdata = data.frame(
          quota_f     = factor("No quota", levels = levels(ipu$quota_f)),
          electoral_f = factor("Plurality/Majority", levels = levels(ipu$electoral_f)),
          years_c     = 20
        ))

predict(model_rep,
        newdata = data.frame(
          quota_f     = factor("No quota", levels = levels(ipu$quota_f)),
          electoral_f = factor("Proportional", levels = levels(ipu$electoral_f)),
          years_c     = 20
        ))
