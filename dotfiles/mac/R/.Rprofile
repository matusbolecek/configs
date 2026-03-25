if (interactive()) {
  brave <- "'/Applications/Brave Browser.app/Contents/MacOS/Brave Browser'"
  options(browser = function(url) {
    system(paste0(brave, " --app=", shQuote(url), " --window-size=800,600 > /dev/null 2>&1"), wait = FALSE)
  })
  options(device = function(...) httpgd::hgd(silent = TRUE))
  plot_open <- function() httpgd::hgd_browse()
}
