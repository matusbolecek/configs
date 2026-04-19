local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    r = { "air" },
    rmd = { "injected" },
    python = { "black" },
    cpp = { "clang_format" },
    c = { "clang_format" },
  },
  formatters = {
    black = {
      command = vim.fn.stdpath("data") .. "/mason/bin/black",
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
return options
