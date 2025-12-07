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
        -- 加载诊断快捷键配置
        require("core.keymaps.diagnostics").setup()

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

        -- 使用新的 vim.lsp.config API (Neovim 0.11+)
        vim.lsp.config.pyright = {
            capabilities = capabilities,
            on_attach = on_attach,

            -- 确保每次配置刷新都写入 venv/extraPaths
            before_init = function(_, cfg)
                local py = python.python_from_venv()
                local sps = python.site_packages_list() or (python.site_packages() and { python.site_packages() })
                local venv_dir = python.get_venv() or python.find_project_venv()
                cfg.settings = cfg.settings or {}
                cfg.settings.python = cfg.settings.python or {}
                if py then
                    cfg.settings.python.defaultInterpreterPath = py
                    cfg.settings.python.pythonPath = py -- compatibility for older pyright
                end
                if venv_dir then
                    cfg.settings.python.venvPath = vim.fn.fnamemodify(venv_dir, ":h")
                    cfg.settings.python.venv = vim.fn.fnamemodify(venv_dir, ":t")
                end
                cfg.settings.python.analysis = cfg.settings.python.analysis or {}
                if sps and #sps > 0 then
                    cfg.settings.python.analysis.extraPaths = sps
                end
                -- Ensure pyright process sees the venv via environment
                if venv_dir then
                    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
                    local path_sep = (sep == "\\") and ";" or ":"
                    local bin_dir = venv_dir .. sep .. (sep == "\\" and "Scripts" or "bin")
                    local current_path = vim.env.PATH or os.getenv("PATH") or ""
                    cfg.cmd_env = cfg.cmd_env or {}
                    cfg.cmd_env.VIRTUAL_ENV = venv_dir
                    cfg.cmd_env.PATH = bin_dir .. path_sep .. current_path
                end
            end,
            on_new_config = function(cfg)
                local py = python.python_from_venv()
                local sps = python.site_packages_list() or (python.site_packages() and { python.site_packages() })
                local venv_dir = python.get_venv() or python.find_project_venv()
                cfg.settings = cfg.settings or {}
                cfg.settings.python = cfg.settings.python or {}
                if py then
                    cfg.settings.python.defaultInterpreterPath = py
                    cfg.settings.python.pythonPath = py -- compatibility for older pyright
                end
                if venv_dir then
                    cfg.settings.python.venvPath = vim.fn.fnamemodify(venv_dir, ":h")
                    cfg.settings.python.venv = vim.fn.fnamemodify(venv_dir, ":t")
                end
                cfg.settings.python.analysis = cfg.settings.python.analysis or {}
                if sps and #sps > 0 then
                    cfg.settings.python.analysis.extraPaths = sps
                end
                if venv_dir then
                    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
                    local path_sep = (sep == "\\") and ";" or ":"
                    local bin_dir = venv_dir .. sep .. (sep == "\\" and "Scripts" or "bin")
                    local current_path = vim.env.PATH or os.getenv("PATH") or ""
                    cfg.cmd_env = cfg.cmd_env or {}
                    cfg.cmd_env.VIRTUAL_ENV = venv_dir
                    cfg.cmd_env.PATH = bin_dir .. path_sep .. current_path
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
        }

        -- 启用 Pyright LSP
        vim.lsp.enable("pyright")

        --------------------------------------------------------------------------
        -- ② clangd ─ C/C++ LSP
        --------------------------------------------------------------------------
        vim.lsp.config.clangd = {
            capabilities = capabilities,
            on_attach = on_attach,

            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--completion-style=detailed",
                "--header-insertion=iwyu",
            },

            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },

            root_dir = vim.fs.root(0, {
                "compile_commands.json",
                "compile_flags.txt",
                ".git",
            }),
        }

        -- 启用 clangd
        vim.lsp.enable("clangd")

        --------------------------------------------------------------------------
        -- ③ 取消 Ruff-LSP：若仅需格式化，请使用 conform.nvim
        --    如需 Ruff 诊断/Code Action，可在此重新启用
        --------------------------------------------------------------------------
    end,
}
