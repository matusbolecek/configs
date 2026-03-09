if (interactive()) {
  options(browser = function(url) {
    system(paste("WEBKIT_DISABLE_COMPOSITING_MODE=1 surf", shQuote(url), "> /dev/null 2>&1"), wait = FALSE)
  })

  options(device = function(...) httpgd::hgd(silent = TRUE))
  plot_open <- function() httpgd::hgd_browse()
}
