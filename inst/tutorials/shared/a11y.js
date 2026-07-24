/* qpaTutorials shared accessibility helpers
   Safe for learnr + shiny_prerendered + static HTML.
   Key rule: NEVER assume jQuery/Shiny globals exist at script load time.
*/

(function () {

  console.log("QPA a11y.js loaded");

  /* ------------------------------
     Helpers
     ------------------------------ */

  function whenDOMReady(fn) {
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", fn);
    } else {
      fn();
    }
  }

  function safe(fn) {
    try {
      fn();
    } catch (e) {
      // swallow to avoid breaking the tutorial
    }
  }

  /* ------------------------------
     Accessibility Toggle Block
     ------------------------------ */

  function insertA11yBlock() {
    // If already in the visible DOM, nothing to do.
    if (document.getElementById("a11y-toggle")) return;

    // Try learnr's actual container first, then fallbacks
    var firstHeading =
      document.querySelector("#learnr-tutorial-content h2") ||
      document.querySelector("#tutorial-container h2") ||
      document.querySelector("h2");

    if (!firstHeading) return; // DOM not ready yet

    var container = document.createElement("div");
    container.setAttribute("role", "region");
    container.setAttribute("aria-label", "Accessibility Instructions");

    container.innerHTML =
      '<div style="background:#f3f3f3;border:1px solid #ccc;border-radius:6px;margin:20px 0;">' +
        '<button id="a11y-toggle"' +
          ' style="width:100%;padding:12px;background:none;border:none;text-align:left;cursor:pointer;font-weight:600;"' +
          ' aria-expanded="false"' +
          ' aria-controls="a11y-content">' +
          '&#9654; Accessibility &amp; Navigation Guide' +
        '</button>' +
        '<div id="a11y-content" style="display:none;padding:0 16px 16px 16px;">' +
          '<p><strong>Keyboard navigation:</strong></p>' +
          '<ul>' +
            '<li>Tab moves between section headings</li>' +
            '<li>Enter jumps to selected heading</li>' +
            '<li>Ctrl + F searches within tutorial</li>' +
          '</ul>' +
          '<p><strong>Important:</strong></p>' +
          '<ul>' +
            '<li>Exercise buttons may require mouse/trackpad</li>' +
            '<li>Code editors may require clicking before typing</li>' +
          '</ul>' +
          '<p style="font-size:0.9em;color:#555;">' +
            "We have enhanced accessibility where possible within learnr's platform limits." +
          '</p>' +
        '</div>' +
      '</div>';

    firstHeading.parentNode.insertBefore(container, firstHeading.nextSibling);

    var btn = document.getElementById("a11y-toggle");
    var content = document.getElementById("a11y-content");

    if (btn && content) {
      btn.addEventListener("click", function () {
        var expanded = content.style.display === "block";
        content.style.display = expanded ? "none" : "block";
        btn.setAttribute("aria-expanded", (!expanded).toString());
        btn.innerHTML = expanded
          ? "&#9654; Accessibility &amp; Navigation Guide"
          : "&#9660; Accessibility &amp; Navigation Guide";
      });
    }
  }

  function startA11yInsertionPolling() {
    var tries = 0;
    var iv = setInterval(function () {
      safe(insertA11yBlock);
      tries += 1;
      if (document.getElementById("a11y-toggle") || tries > 40) {
        clearInterval(iv);
      }
    }, 500);
  }

  /* ------------------------------
     MathJax Re-typeset
     ------------------------------ */

  function retypeset() {
    safe(function () {
      if (window.MathJax && window.MathJax.Hub) {
        // MathJax v2 HTML-CSS renderer
        window.MathJax.Hub.Queue(["Typeset", window.MathJax.Hub], function() {
          // Fix inline math sizing after typesetting
          document.querySelectorAll('span.MathJax:not(.MathJax_Display)').forEach(function(el) {
            el.style.fontSize = '0.85em';
          });
        });
      } else if (window.MathJax && window.MathJax.typesetPromise) {
        // MathJax v3 fallback
        window.MathJax.typesetPromise().then(function() {
          document.querySelectorAll('mjx-container:not([display="true"])').forEach(function(el) {
            el.style.fontSize = '0.85em';
            el.style.verticalAlign = 'middle';
          });
        });
      }
    });
  }

  /* ------------------------------
     Enhance Success / Error Messages
     ------------------------------ */

  function enhanceMessages() {
    var successMessages = document.querySelectorAll(
      ".alert-success:not([data-enhanced])"
    );
    successMessages.forEach(function (msg) {
      msg.setAttribute("data-enhanced", "true");
      msg.setAttribute("role", "status");
      msg.setAttribute("aria-live", "polite");
    });

    var errorMessages = document.querySelectorAll(
      ".alert-danger:not([data-enhanced]), .tutorial-exercise-error:not([data-enhanced])"
    );
    errorMessages.forEach(function (msg) {
      msg.setAttribute("data-enhanced", "true");
      msg.setAttribute("role", "alert");
      msg.setAttribute("aria-live", "assertive");
    });
  }

  /* ------------------------------
     Bootstrapping
     ------------------------------ */

  whenDOMReady(function () {
    startA11yInsertionPolling();
    safe(enhanceMessages);
    setInterval(function () { safe(enhanceMessages); }, 1500);
    setTimeout(retypeset, 1000); // initial render

    // Override Safari's native blue focus ring with amber
    document.addEventListener("focusin", function(e) {
      var el = e.target;
      if (el && el.style) {
        el.style.outline = "3px solid #b45309";
        el.style.outlineOffset = "2px";
        el.style.borderRadius = "4px";
      }
    });

    document.addEventListener("focusout", function(e) {
      var el = e.target;
      if (el && el.style) {
        el.style.outline = "";
        el.style.outlineOffset = "";
        el.style.borderRadius = "";
      }
    });
  });

  // Wire up Shiny/learnr events for section navigation.
  safe(function () {
    if (typeof window.jQuery === "undefined") return;

    var $ = window.jQuery;

    // Fires when Shiny first connects
    $(document).on("shiny:connected", function () {
      startA11yInsertionPolling();
      safe(enhanceMessages);
      setTimeout(retypeset, 500);
    });

    // Fires when learnr updates tutorial content (section navigation)
    $(document).on("shiny:value", function (e) {
      if (e.name && e.name.indexOf("section") !== -1) {
        setTimeout(function () {
          safe(insertA11yBlock);
          safe(enhanceMessages);
          retypeset();
        }, 300);
      }
    });
  });

})();
