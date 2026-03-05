require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Molten
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
  { silent = true, desc = "Molten: initialize kernel" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
  { silent = true, desc = "Molten: run operator selection" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
  { silent = true, desc = "Molten: evaluate line" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
  { silent = true, desc = "Molten: re-evaluate cell" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "Molten: evaluate visual selection" })
vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>",
  { silent = true, desc = "Molten: delete cell" })
vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",
  { silent = true, desc = "Molten: hide output" })
vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
  { silent = true, desc = "Molten: enter output window" })

-- Quarto
vim.keymap.set("n", "<localleader>qr", ":QuartoRunLine<CR>",
  { silent = true, desc = "Quarto: run line" })
vim.keymap.set("n", "<localleader>qa", ":QuartoRunAll<CR>",
  { silent = true, desc = "Quarto: run all cells" })
vim.keymap.set("n", "<localleader>qc", ":QuartoRunCell<CR>",
  { silent = true, desc = "Quarto: run cell" })
vim.keymap.set("v", "<localleader>qr", ":QuartoRunRange<CR>",
  { silent = true, desc = "Quarto: run visual range" })

-- Insert python cell below cursor
vim.keymap.set("n", "<A-c>", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, {
    "```{python}",
    "",
    "```",
  })
  vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
  vim.cmd("startinsert")
end, { silent = true, desc = "Insert python cell below" })

vim.keymap.set("v", "<A-c>", function()
  -- exit visual mode first to fix '< '> marks
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  local start_row = vim.fn.line("'<")
  local end_row = vim.fn.line("'>")
  vim.api.nvim_buf_set_lines(0, end_row, end_row, false, { "```" })
  vim.api.nvim_buf_set_lines(0, start_row - 1, start_row - 1, false, { "```{python}" })
end, { silent = true, desc = "Wrap selection in python cell" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
