require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "quarto",
  callback = function()
    require("quarto").activate()
  end,
})
