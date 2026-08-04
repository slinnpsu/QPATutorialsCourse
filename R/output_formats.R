#' qpa tutorial output format (learnr + shared header)
#'
#' Injects shared CSS, JS, and accessibility block into each tutorial
#' at render time via post-processor.
#'
#' @param ... Arguments passed to \code{learnr::tutorial()}.
#' @export
qpa_tutorial <- function(...) {

  fmt <- learnr::tutorial(
    ...,
    shiny_args = list(launch.browser = TRUE)
  )

  old_pp <- fmt$post_processor

  fmt$post_processor <- function(metadata, input_file, output_file, clean, verbose) {

    if (is.function(old_pp)) {
      output_file <- old_pp(metadata, input_file, output_file, clean, verbose)
    }

    html <- paste(readLines(output_file, warn = FALSE), collapse = "\n")

    # ---- Inject CSS inline ----
    if (!grepl("qpa-a11y-css", html, fixed = TRUE)) {
      css_path <- system.file("tutorials/shared/a11y.css", package = "QPATutorialsCourse")
      if (nzchar(css_path)) {
        css_content <- paste(readLines(css_path, warn = FALSE), collapse = "\n")
        css_tag <- paste0("<style id=\"qpa-a11y-css\">\n", css_content, "\n</style>")
        html <- sub("</body>", paste0(css_tag, "\n</body>"), html, fixed = TRUE)
      }
    }

    # ---- Inject static accessibility block before first <h2> ----
    if (!grepl("a11y-toggle", html, fixed = TRUE)) {
      a11y_block <- paste0(
        '<div role="region" aria-label="Accessibility Instructions" ',
        'style="background:#f3f3f3;border:1px solid #ccc;border-radius:6px;margin:20px 0;">',
        '<button id="a11y-toggle" ',
        'style="width:100%;padding:12px;background:none;border:none;text-align:left;',
        'cursor:pointer;font-weight:600;" ',
        'aria-expanded="false" aria-controls="a11y-content" ',
        'onclick="var c=document.getElementById(\'a11y-content\');',
        'var open=c.style.display===\'block\';',
        'c.style.display=open?\'none\':\'block\';',
        'this.setAttribute(\'aria-expanded\',String(!open));',
        'this.innerHTML=open?',
        '\'&#9654; Accessibility &amp; Navigation Guide\':',
        '\'&#9660; Accessibility &amp; Navigation Guide\';">',
        '&#9654; Accessibility &amp; Navigation Guide',
        '</button>',
        '<div id="a11y-content" style="display:none;padding:0 16px 16px 16px;">',
        '<p><strong>Keyboard navigation:</strong></p>',
        '<ul>',
        '<li>Tab moves between interactive elements</li>',
        '<li>Enter activates buttons</li>',
        '<li>Ctrl + F searches within tutorial</li>',
        '</ul>',
        '<p><strong>Important:</strong></p>',
        '<ul>',
        '<li>Exercise buttons may require mouse/trackpad</li>',
        '<li>Code editors may require clicking before typing</li>',
        '</ul>',
        '<p style="font-size:0.9em;color:#555;">',
        'We have enhanced accessibility where possible within learnr\'s platform limits.',
        '</p>',
        '</div>',
        '</div>'
      )
      html <- sub("<h2", paste0(a11y_block, "\n<h2"), html, fixed = TRUE)
    }

    # ---- Inject JS inline ----
    if (!grepl("QPA a11y.js loaded", html, fixed = TRUE)) {
      js_path <- system.file("tutorials/shared/a11y.js", package = "QPATutorialsCourse")
      if (nzchar(js_path)) {
        js_content <- paste(readLines(js_path, warn = FALSE), collapse = "\n")
        js_tag <- paste0("<script>\n", js_content, "\n</script>")
        html <- sub("</body>", paste0(js_tag, "\n</body>"), html, fixed = TRUE)
      }
    }

    writeLines(html, output_file)
    output_file
  }
  fmt
}
