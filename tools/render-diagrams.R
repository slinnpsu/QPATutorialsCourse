# render-diagrams.R -- draw the causal-structure diagrams used in the
#                      regression tutorials and write them to the tutorial
#                      image folders.
#
# WHAT THIS PRODUCES
# ------------------
#   inst/tutorials/16-regressionMultiple/images/spurious.png
#   inst/tutorials/16-regressionMultiple/images/correlated.png
#   inst/tutorials/18-regressionInteractions/images/conditional.png
#
# The diagram definitions below are unchanged from the version that produced
# the images currently in the package, so re-running this reproduces them
# exactly. Only the output paths and the documentation have changed.
#
# WHY THE PATHS CHANGED
# ---------------------
# An earlier version of this script wrote conditional.png to
# "17-regressionInteractions". Interactions became tutorial 18 when the
# tutorials were split and renumbered, so the file went to a folder no
# tutorial reads, and T18's include_graphics() call has been erroring on a
# missing image ever since. If the tutorials are renumbered again, the three
# paths below are what must follow.
#
# WHY NOT MERMAID
# ---------------
# The course reading draws these with mermaid, which does not render reliably
# in learnr. Rendering to PNG here and including the image keeps the tutorials
# independent of that.
#
# WHAT EACH DIAGRAM HAS TO SHOW
# -----------------------------
# The three structures are easy to confuse, and each diagram earns its place by
# showing exactly one of them:
#
#   spurious      X2 -> X1 and X2 -> Y, with NO arrow from X1 to Y.
#                 The X1-Y association is entirely produced by X2, so it
#                 disappears once X2 is in the model. The ABSENCE of the
#                 X1 -> Y arrow is the whole point --- do not add one.
#
#   correlated    X1 -> X2, X1 -> Y, and X2 -> Y.
#                 X1 really is related to Y. The bivariate estimate is wrong
#                 about the SIZE of that relationship, not its existence, so
#                 the X1 -> Y arrow must be present here.
#
#   conditional   X1 -> Y, and X2 -> Y carrying the label "changes the effect
#                 of X1". X2 does not produce or bias the X1-Y relationship;
#                 it changes how strong that relationship is. The label is
#                 what distinguishes this from the correlated-cause diagram,
#                 since both draw an arrow from X2 into Y --- so the label is
#                 not decoration and must not be dropped.
#
# The box in the conditional diagram reads "Conditioning variable" because
# that matches the tutorials, which speak of conditional relationships and
# never use the word "moderator".
#
# USAGE, from the package root (the folder holding DESCRIPTION):
#
#     Rscript tools/render-diagrams.R
#
# Reinstall the package afterwards so the tutorials pick up the images.

library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

if (!dir.exists("inst")) {
  stop("Run this from the package root (the folder holding DESCRIPTION).")
}

out_dir_16 <- "inst/tutorials/16-regressionMultiple/images"
out_dir_18 <- "inst/tutorials/18-regressionInteractions/images"
dir.create(out_dir_16, recursive = TRUE, showWarnings = FALSE)
dir.create(out_dir_18, recursive = TRUE, showWarnings = FALSE)

## Render a grViz diagram to PNG via a temporary SVG.
## The width and height set the raster size; the tutorials scale the result
## with out.width, so these control resolution rather than displayed size.
# Render at the SVG's OWN size -- pass neither width nor height. NODE_STYLE
# already fixes the node size and font size in graphviz units, so an unscaled
# render makes a box the same number of pixels in every diagram, whatever the
# layout. Forcing a common width, or a common height, rescales each diagram by a
# different factor and the boxes come out visibly different sizes on the page.
# Set each chunk's out.width in proportion to the widths printed below.
# Read a PNG's pixel dimensions from its header, using base R only.
png_dim <- function(f) {
  con <- file(f, "rb"); on.exit(close(con))
  readBin(con, "raw", 16)                       # signature + IHDR length/type
  be <- function() sum(as.numeric(readBin(con, "raw", 4)) * c(256^3, 256^2, 256, 1))
  c(be(), be())
}

save_png <- function(diagram, filename, dirs, scale = 2) {
  svg <- export_svg(diagram)
  tmp <- tempfile(fileext = ".svg")
  writeLines(svg, tmp)
  # The SVG header carries its own width, e.g. <svg width="553pt" ...>.
  hit <- regmatches(svg, regexpr('width="[0-9.]+', svg))
  nat <- as.numeric(sub('width="', "", hit))
  for (d in dirs) {
    out <- file.path(d, filename)
    rsvg_png(tmp, file = out, width = round(nat * scale))
    cat("Saved:", out, "-", paste(png_dim(out), collapse = " x "), "\n")
  }
  unlink(tmp)
}

## Shared node and edge styling, kept identical across the three diagrams so
## they read as a set: pale fill and a thin border, which lets the arrows
## carry the visual weight, since the arrows are the claim.
NODE_STYLE <- "node [shape = rectangle, style = filled, fillcolor = '#dce8f5',
          color = '#4a90c4', fontcolor = '#1d4e89', fontname = 'Helvetica',
          fontsize = 14, width = 1.8, height = 0.7]"
EDGE_STYLE <- "edge [color = '#1d4e89', arrowsize = 0.8]"

# --- Diagram 1: Spurious relationship (T16) ---
d1 <- grViz(paste0("
  digraph spurious {
    graph [layout = dot, rankdir = LR, bgcolor = white]
    ", NODE_STYLE, "
    X2 [label = 'X\u2082\nOmitted cause']
    X1 [label = 'X\u2081\nExplanatory variable']
    Y  [label = 'Y\nOutcome variable']
    ", EDGE_STYLE, "
    X2 -> X1
    X2 -> Y
  }
"))
save_png(d1, "spurious.png", list(out_dir_16))

# --- Diagram 2: Multiple correlated causes (T16) ---
d2 <- grViz(paste0("
  digraph correlated {
    graph [layout = dot, rankdir = LR, bgcolor = white]
    ", NODE_STYLE, "
    X1 [label = 'X\u2081\nExplanatory variable']
    X2 [label = 'X\u2082\nCorrelated cause']
    Y  [label = 'Y\nOutcome variable']
    ", EDGE_STYLE, "
    X1 -> X2
    X1 -> Y
    X2 -> Y
  }
"))
save_png(d2, "correlated.png", list(out_dir_16))

# --- Diagram 3: Conditional relationship (T18) ---
d3 <- grViz(paste0("
  digraph conditional {
    graph [layout = dot, rankdir = LR, bgcolor = white]
    ", NODE_STYLE, "
    X1 [label = 'X\u2081\nExplanatory variable']
    X2 [label = 'X\u2082\nConditioning variable']
    Y  [label = 'Y\nOutcome variable']
    ", EDGE_STYLE, "
    X1 -> Y
    X2 -> Y [label = 'changes the\neffect of X\u2081',
              fontcolor = '#1d4e89', fontsize = 11]
  }
"))
save_png(d3, "conditional.png", list(out_dir_18))

cat("\nDone. Reinstall the package to make the images available to the tutorials.\n")
