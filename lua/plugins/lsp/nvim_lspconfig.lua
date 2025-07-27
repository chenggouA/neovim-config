return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "pyright", "lua_ls" },
        automatic_enable = true,
        automatic_installation = true,
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = ok_cmp and cmp_lsp.default_capabilities()
      or vim.lsp.protocol.make_client_capabilities()

    local on_attach = require("core.keymaps.lsp").on_attach

    local python = require("core.python")

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      before_init = function(_, cfg)
        local py = python.python_from_venv()
        local sp = python.site_packages()
        cfg.settings = cfg.settings or {}
        cfg.settings.python = cfg.settings.python or {}
        if py then
          cfg.settings.python.defaultInterpreterPath = py
        end
        cfg.settings.python.analysis = cfg.settings.python.analysis or {}
        if sp then
          cfg.settings.python.analysis.extraPaths = { sp }
        end
      end,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
}
