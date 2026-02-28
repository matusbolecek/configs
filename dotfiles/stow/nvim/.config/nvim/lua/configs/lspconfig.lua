local lsp_configs = require("lspconfig.configs")
local nvlsp = require("nvchad.configs.lspconfig")

-- Initialize NvChad's default global mappings
nvlsp.defaults()

local servers = { "html", "cssls", "pyright", "r_language_server", "marksman"}

for _, name in ipairs(servers) do
  local config = lsp_configs[name] and lsp_configs[name].default_config or {}

  config = vim.tbl_deep_extend("force", config, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  if name == "pyright" then
    config.settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true
        }
      }
    }
  end

  if name == "r_language_server" then
    local original_on_attach = nvlsp.on_attach
    config.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      original_on_attach(client, bufnr)
    end
  end

   if name == "marksman" then
    config.filetypes = { "markdown", "rmd", "quarto" }
   end

  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end
