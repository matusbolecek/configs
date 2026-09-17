require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "quarto",
  callback = function()
    require("quarto").activate()
  end,
})

-- nvchad starts treesitter for every filetype; vimtex needs its own syntax
-- for highlighting and math zone detection in snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex" },
  callback = function(args)
    vim.treesitter.stop(args.buf)
    vim.bo[args.buf].syntax = "tex"
  end,
})
