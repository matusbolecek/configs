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
    opts.sources = vim.list_extend(opts.sources or {}, {
      { name = "otter" },
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
        auto_start      = "no",
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
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
    },
  },
    {
    "benlubas/molten-nvim",
    lazy = false,
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      -- Image rendering via Kitty
      vim.g.molten_image_provider = "image.nvim"

      -- Output window settings
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_virt_text_output = true       -- show output as virtual text
      vim.g.molten_virt_lines_off_by_1 = true    -- better for markdown/python files
      vim.g.molten_wrap_output = true
      vim.g.molten_auto_open_output = false       -- don't auto-open; use virt text instead
      vim.g.molten_use_border_highlights = true   -- color-coded borders per cell state
    end,
  },
{
  "quarto-dev/quarto-nvim",
  lazy = false,
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    lspFeatures = {
      enabled = true,
      chunks = "curly",
      languages = { "python" },
      diagnostics = {
        enabled = true,
        triggers = { "BufWritePost" },
      },
      completion = { enabled = true },
    },
    codeRunner = {
      enabled = true,
      default_method = "molten",
    },
  },
},
{
  "jmbuhr/otter.nvim",
  opts = {},
},
}
