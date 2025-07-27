return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        { "mason-org/mason.nvim", opts = {} },

        -- Mason‑LspConfig：只改 ensure_installed
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "pyright", "lua_ls", "ruff" }, -- ★ 新增
                automatic_enable = false,                           -- 不自动启动
                automatic_installation = true,
            },
        },

        -- 若你有 nvim‑cmp，可继续依赖 cmp-nvim-lsp；没装就忽略
        -- { "hrsh7th/cmp-nvim-lsp", lazy = true },
    },

    config = function()
        local lspconfig = require("lspconfig")

        --------------------------------------------------------------------------
        -- 公共 capabilities
        --------------------------------------------------------------------------
        local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = ok_cmp and cmp_lsp.default_capabilities()
            or vim.lsp.protocol.make_client_capabilities()

        --------------------------------------------------------------------------
        -- 公共 on_attach：保存前自动格式化（谁能格式化谁执行）
        --------------------------------------------------------------------------
        local on_attach = function(client, bufnr)
            local ok, lsp_keys = pcall(require, "core.keymaps.lsp")
            if ok and type(lsp_keys.on_attach) == "function" then
                lsp_keys.on_attach(client, bufnr)
            end
            -- 如果 LSP 提供格式化，就在 BufWritePre 调用
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ timeout_ms = 5000 })
                    end,
                })
            end
        end

        --------------------------------------------------------------------------
        -- ① Pyright ─ 类型检查
        --------------------------------------------------------------------------
        local python = require("core.python")

        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach    = on_attach,

            -- 你的 venv 逻辑保留
            before_init  = function(_, cfg)
                local py = python.python_from_venv()
                local sp = python.site_packages()
                cfg.settings = cfg.settings or {}
                cfg.settings.python = cfg.settings.python or {}
                if py then cfg.settings.python.defaultInterpreterPath = py end

                cfg.settings.python.analysis = cfg.settings.python.analysis or {}
                if sp then cfg.settings.python.analysis.extraPaths = { sp } end
            end,

            settings     = {
                python = {
                    analysis = {
                        typeCheckingMode       = "basic",
                        autoSearchPaths        = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode         = "openFilesOnly",
                    },
                },
            },
        })

        --------------------------------------------------------------------------
        -- ② Ruff‑LSP ─ 诊断 + 格式化 + Code Action
        --------------------------------------------------------------------------
        lspconfig.ruff.setup({
            capabilities = capabilities,
            on_attach    = on_attach, -- 同一个 on_attach

            -- ❓ 如需 CLI 额外参数，可在 init_options.settings.args 写 Ruff 参数
            -- init_options = {
            --   settings = { args = { "--line-length", "100" } },
            -- },
        })

        --------------------------------------------------------------------------
        -- ③ Lua 语言服务器
        --------------------------------------------------------------------------
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace   = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry   = { enable = false },
                },
            },
        })
    end,
}
