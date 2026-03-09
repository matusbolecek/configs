require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Molten & Quarto (buffer-local: only active in quarto/python buffers)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "quarto", "python" },
  callback = function(ev)
    local opts = function(desc)
      return { silent = true, buffer = ev.buf, desc = desc }
    end

    -- Molten
    vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",                  opts("Molten: initialize kernel"))
    vim.keymap.set("n", "<localleader>me", ":MoltenEvaluateOperator<CR>",      opts("Molten: run operator selection"))
    vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>",          opts("Molten: evaluate line"))
    vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>",        opts("Molten: re-evaluate cell"))
    vim.keymap.set("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", opts("Molten: evaluate visual selection"))
    vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>",                opts("Molten: delete cell"))
    vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>",            opts("Molten: hide output"))
    vim.keymap.set("n", "<localleader>mo", ":noautocmd MoltenEnterOutput<CR>", opts("Molten: enter output window"))

    -- Quarto
    vim.keymap.set("n", "<localleader>ql", ":QuartoRunLine<CR>",               opts("Quarto: run line"))
    vim.keymap.set("n", "<localleader>qa", ":QuartoRunAll<CR>",                opts("Quarto: run all cells"))
    vim.keymap.set("n", "<localleader>qc", ":QuartoRunCell<CR>",               opts("Quarto: run cell"))
    vim.keymap.set("v", "<localleader>qv", ":QuartoRunRange<CR>",              opts("Quarto: run visual range"))

    -- Insert python cell
    vim.keymap.set("n", "<A-c>", function()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row, row, false, { "```{python}", "", "```" })
      vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
      vim.cmd("startinsert")
    end, opts("Insert python cell below"))

    vim.keymap.set("v", "<A-c>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
      local start_row = vim.fn.line("'<")
      local end_row   = vim.fn.line("'>")
      vim.api.nvim_buf_set_lines(0, end_row,       end_row,       false, { "```" })
      vim.api.nvim_buf_set_lines(0, start_row - 1, start_row - 1, false, { "```{python}" })
    end, opts("Wrap selection in python cell"))
  end,
})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
