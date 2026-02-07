local lsp_configs = require("lspconfig.configs")
local nvlsp = require("nvchad.configs.lspconfig")

-- Initialize NvChad's default global mappings
nvlsp.defaults()

local servers = { "html", "cssls", "pyright" }

for _, name in ipairs(servers) do
  -- 1. Get the base config from nvim-lspconfig (cmd, filetypes, etc.)
  -- We access .default_config directly to avoid the "deprecated" warning
  local config = lsp_configs[name] and lsp_configs[name].default_config or {}

  -- 2. Merge NvChad's standard "on_attach", "on_init", and "capabilities"
  -- This ensures autocomplete (cmp) and UI features work
  config = vim.tbl_deep_extend("force", config, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  -- 3. Add Specific Settings for Pyright
  if name == "pyright" then
    config.settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic", -- Use "strict" for aggressive checking
          autoSearchPaths = true,
          useLibraryCodeForTypes = true
        }
      }
    }
  end

  -- 4. Apply the config to the native Neovim 0.11+ system
  vim.lsp.config[name] = config

  -- 5. Enable the server (starts it automatically when you open a file)
  vim.lsp.enable(name)
end
