.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "Welcome to QPATutorialsCourse!\n",
    "These graded tutorials support PLSC 309H: Quantitative Political Analysis\n",
    "at Penn State University, covering R basics, univariate and bivariate\n",
    "description, hypothesis testing, regression, and logistic regression.\n\n",
    "To see all available tutorials, run: learnr::available_tutorials('QPATutorialsCourse')\n",
    "To open a tutorial, run: qpa_launch(1) through qpa_launch(20)\n",
    "Example: qpa_launch(1) opens R Basics Part 1"
  )
}
