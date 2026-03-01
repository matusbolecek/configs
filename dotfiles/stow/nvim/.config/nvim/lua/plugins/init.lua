return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      })
      -- If you want to use it as the main theme, you must call it here
      vim.cmd.colorscheme "catppuccin"
    end,
  },

{
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping.confirm { select = true },
      ["<CR>"] = cmp.mapping.close(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
    })
    return opts
  end,
},

 {
  "nvim-treesitter/nvim-treesitter",
  init = function()
    require("nvim-treesitter.install").compilers = { "clang" }
  end,
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "r",
      "rnoweb",
      "markdown",
      "markdown_inline",
      "yaml",
      "latex",
    })
  end,
},

{
  "R-nvim/R.nvim",
  lazy = false,
  config = function()
    require("r").setup({
      auto_start = "on startup",
      pipe_version = "native",
      rconsole_width = 60,
      rconsole_height = 15,
      external_term = "alacritty",
    })

    vim.keymap.set("n", "<F9>", function()
      require("r.send").cmd("plot_open()")
    end, { desc = "Open httpgd plot viewer" })
    vim.keymap.set("n", "<F10>", function()
      require("r.browser").start()
    end, { desc = "Open R object browser" })
  end,
},

{
"stevearc/conform.nvim",
event = "BufWritePre",
config = function()
require "configs.conform"
end,
},
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
