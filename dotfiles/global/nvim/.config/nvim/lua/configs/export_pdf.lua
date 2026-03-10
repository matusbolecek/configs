local M = {}

M.setup = function()
  vim.keymap.set("n", "<leader>mc", function()
    local file = vim.fn.expand("%:p")
    local out  = vim.fn.expand("%:p:r") .. ".pdf"

    if vim.fn.expand("%:e") ~= "md" then
      vim.notify("Not a markdown file", vim.log.levels.WARN)
      return
    end

    vim.cmd("w")
    vim.notify("Compiling " .. vim.fn.expand("%:t") .. "...", vim.log.levels.INFO)
    vim.fn.jobstart({ "pandoc", file, "-o", out, "--pdf-engine=xelatex" }, {
      detach = false,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("PDF saved to " .. out, vim.log.levels.INFO)
        else
          vim.notify("Compilation failed — check pandoc/xelatex is installed", vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = "Compile markdown to PDF" })
end

return M
