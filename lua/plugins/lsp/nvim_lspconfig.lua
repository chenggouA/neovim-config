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

    local function python_from_venv()
      local venv = vim.env.VIRTUAL_ENV
      if not (venv and #venv > 0) then return nil end
      local sep = package.config:sub(1,1) == "\\" and "\\" or "/"
      return venv .. sep .. (sep == "\\" and "Scripts\\python.exe" or "bin/python")
    end

    local function site_packages()
      local venv = vim.env.VIRTUAL_ENV
      if not (venv and #venv > 0) then return nil end
      local sep = package.config:sub(1,1) == "\\" and "\\" or "/"
      if sep == "\\" then
        return venv .. "\\Lib\\site-packages"
      else
        local pyver = vim.version().major .. "." .. vim.version().minor
        return string.format("%s/lib/python%s/site-packages", venv, pyver)
      end
    end

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      before_init = function(_, cfg)
        local py = python_from_venv()
        local sp = site_packages()
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
