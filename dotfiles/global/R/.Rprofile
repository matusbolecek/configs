# create a profile first:
# mkdir .firefox/httpgd
# firefox --CreateProfile "httpgd /home/user/.firefox/httpgd"
# in normal dots handled by the stow install script

if (interactive()) {
  options(browser = function(url) {
    system(paste("firefox --profile ~/.firefox/httpgd/ --no-remote --class fakefull --kiosk --private", shQuote(url), "> /dev/null 2>&1"), wait = FALSE)
  })

  options(device = function(...) httpgd::hgd(silent = TRUE))
  plot_open <- function() httpgd::hgd_browse()
}
