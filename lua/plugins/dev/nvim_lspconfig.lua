return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        { "mason-org/mason.nvim", opts = {} },

        -- Mason‑LspConfig：只改 ensure_installed
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "pyright"},
                automatic_enable = false, -- 不自动启动
                automatic_installation = true,
            },
        },

    },

    config = function()
        require("core.keymaps.diagnostics").setup()
        local lspconfig = require("lspconfig")

        --------------------------------------------------------------------------
        -- 公共 capabilities
        --------------------------------------------------------------------------
        local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = ok_cmp and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = { "utf-16" }

        local on_attach = function(client, bufnr)
            local ok, lsp_keys = pcall(require, "core.keymaps.lsp")
            if ok and type(lsp_keys.on_attach) == "function" then
                lsp_keys.on_attach(client, bufnr)
            end
        end
        --------------------------------------------------------------------------
        -- ① Pyright ─ 类型检查
        --------------------------------------------------------------------------
        ---@type CorePython
        local python = require("core.python")

        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,

            -- 你的 venv 逻辑保留
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

        --------------------------------------------------------------------------
        -- ② 取消 Ruff-LSP：若仅需格式化，请使用 conform.nvim
        --    如需 Ruff 诊断/Code Action，可在此重新启用
        --------------------------------------------------------------------------
    end,
}
