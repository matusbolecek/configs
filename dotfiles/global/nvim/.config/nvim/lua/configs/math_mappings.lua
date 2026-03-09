local M = {}
local matrix_envs = {
  "pmatrix", "bmatrix", "Bmatrix", "vmatrix", "Vmatrix",
  "matrix", "cases", "align", "aligned", "array"
}

local function is_comment(line)
  return line:match("^%s*%%") ~= nil
end

local function in_matrix_env()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  -- Treesitter path
  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if ok and parser then
    parser:parse()
    local node_ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
    if node_ok and node then
      local n = node
      while n do
        local ntype = n:type()
        if ntype == "generic_environment" or ntype == "math_environment" then
          local text = vim.treesitter.get_node_text(n, 0)
          for _, env in ipairs(matrix_envs) do
            if text:find("\\begin{" .. env .. "}", 1, true) then
              return true
            end
          end
        end
        n = n:parent()
      end
    end
  end

  -- Regex fallback
  local start_row = math.max(0, row - 30)
  local lines = vim.api.nvim_buf_get_lines(0, start_row, row, false)
  if #lines > 0 then
    lines[#lines] = string.sub(lines[#lines], 1, col)
  end
  local balance = 0
  for r = #lines, 1, -1 do
    local line = lines[r]
    if not is_comment(line) then
      for _, env in ipairs(matrix_envs) do
        local _, end_count = line:gsub("\\end{" .. env .. "}", "")
        balance = balance + end_count
        local _, begin_count = line:gsub("\\begin{" .. env .. "}", "")
        if begin_count > 0 then
          balance = balance - begin_count
          if balance < 0 then return true end
        end
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
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
      end
    end, { buffer = true, desc = "Matrix & or normal Tab" })

    vim.keymap.set("i", "<CR>", function()
      if in_matrix_env() then
        vim.api.nvim_feedkeys(" \\\\\n", "n", true)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
      end
    end, { buffer = true, desc = "Matrix newline or normal CR" })
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex", "plaintex" },
    callback = set_matrix_keys,
  })
end

return M
