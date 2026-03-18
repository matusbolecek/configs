local M = {}

M.setup = function()
  vim.keymap.set("n", "<leader>mc", function()
    local e = vim.fn.expand("%:e")
    local f = vim.fn.expand("%:p")
    vim.cmd("w")

    local cmd = e == "qmd"
        and { "quarto", "render", f, "--to", "pdf" }
        or { "pandoc", f, "-o", vim.fn.expand("%:p:r") .. ".pdf", "--pdf-engine=xelatex" }

    local stderr_lines = {}

    vim.notify("Rendering " .. vim.fn.expand("%:t") .. "...", vim.log.levels.INFO)
    vim.fn.jobstart(cmd, {
      stderr_buffered = true,
      on_stderr = function(_, data)
        if data then
          vim.list_extend(stderr_lines, data)
        end
      end,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("PDF done!", vim.log.levels.INFO)
        else
          local msg = table.concat(stderr_lines, "\n")
          vim.notify(msg ~= "" and msg or "Render failed (no output)", vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = "Compile/render to PDF" })
end

return M
