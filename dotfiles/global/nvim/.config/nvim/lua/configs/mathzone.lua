local M = {}

-- Counts $ delimiters to determine if cursor is inside inline or display math.
local function in_dollar_math()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local line = lines[row]
  local before_cursor = line:sub(1, col)

  -- Inline math: odd number of $ before cursor on this line
  local _, inline_count = before_cursor:gsub("%$", "")
  if inline_count % 2 == 1 then return true end

  -- Display math: odd number of $$ blocks above cursor
  local display_count = 0
  for r = 1, row - 1 do
    local _, c = lines[r]:gsub("%$%$", "")
    display_count = display_count + c
  end
  local _, c = before_cursor:gsub("%$%$", "")
  display_count = display_count + c
  return display_count % 2 == 1
end

-- LaTeX uses vimtex's syntax-based detection (\[ \], equation, align, ...)
M.in_mathzone = function()
  local ft = vim.bo.filetype
  if ft == "tex" or ft == "plaintex" then
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
  end
  return in_dollar_math()
end

return M
