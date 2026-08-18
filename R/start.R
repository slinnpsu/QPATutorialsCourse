.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "Welcome to QPATutorialsCourse.\n\n",
    "Twenty-one tutorials on quantitative political analysis: R basics,\n",
    "describing variables one and two at a time, statistical inference,\n",
    "regression, and logistic regression.\n\n",
    "  qpa_launch()    lists all tutorials, grouped, with what each one needs\n",
    "  qpa_launch(1)   opens a tutorial\n",
    "  open_reading()  lists the readings that come with the package\n\n",
    "Tutorials can also be opened by name: qpa_launch(\"univariateNom\")."
  )
}
