local M = {}

local matrix_envs = {
  "pmatrix", "bmatrix", "Bmatrix", "vmatrix", "Vmatrix",
  "matrix", "cases", "align", "array"
}

local function in_matrix_env()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
  for r = #lines, 1, -1 do
    local line = lines[r]
    for _, env in ipairs(matrix_envs) do
      if line:match("\\begin{" .. env .. "}") then
        return true
      end
      if line:match("\\end{" .. env .. "}") then
        return false
      end
    end
  end
  return false
end

M.setup = function()
  local function set_matrix_keys()
    vim.keymap.set("i", "<Tab>", function()
      if in_matrix_env() then
        vim.api.nvim_feedkeys(" & ", "n", true)
      else
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
        end
      end
    end, { buffer = true, desc = "Matrix & or LuaSnip expand" })

    vim.keymap.set("i", "<CR>", function()
      if in_matrix_env() then
        vim.api.nvim_feedkeys(" \\\\\n", "n", true)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
      end
    end, { buffer = true, desc = "Matrix newline or normal CR" })
  end

  local function clear_matrix_keys()
    pcall(vim.keymap.del, "i", "<Tab>", { buffer = true })
    pcall(vim.keymap.del, "i", "<CR>",  { buffer = true })
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = set_matrix_keys,
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    pattern = { "*.md", "*.markdown" },
    callback = clear_matrix_keys,
  })
end

return M
