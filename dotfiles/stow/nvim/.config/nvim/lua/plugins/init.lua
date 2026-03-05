require("configs.math_mappings").setup()
require("configs.export_pdf").setup()

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
      vim.keymap.set("n", "<leader>fm", function()
        require("conform").format()
      end, { desc = "Format file" })
    end,
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
      vim.cmd.colorscheme "catppuccin"
    end,
  },
{
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { select = true }
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<CR>"]  = cmp.mapping.close(),
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
        auto_start      = "on startup",
        pipe_version    = "native",
        rconsole_width  = 60,
        rconsole_height = 15,
        external_term   = "kitty",
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
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 1
    end,
  },
{
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    require("luasnip").setup(vim.tbl_deep_extend("force", opts or {}, {
      enable_autosnippets = true,
    }))
    require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

    -- LuaSnip jumps on C-l/C-h, never on Tab
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      local ls = require("luasnip")
      if ls.jumpable(1) then ls.jump(1) end
    end)
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      local ls = require("luasnip")
      if ls.jumpable(-1) then ls.jump(-1) end
    end)
  end,
},
  {
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>mp", function() require("nabla").popup() end, desc = "Math Popup" },
    },
    config = function()
    end
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "3rd/image.nvim" },
    ft = { "markdown" },
    opts = {
      latex = {
        enabled = true,
        converter = "latex2text", 
        render_modes = { "n", "c" }, 
      },
      win_options = {
        conceallevel = {
          default = 2,
          rendered = 2,
        },
      },
    },
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, 
        },
      },
      max_width = 100,
      max_height = 20,
    },
  },
}
