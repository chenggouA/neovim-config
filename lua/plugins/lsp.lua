-- 语言服务相关插件，可在此扩展
-- ~/.config/nvim/lua/plugins/lsp.lua  (或任何你放 Lazy 列表的文件)
return {
  -- ① Mason 主体（可空 opts）
  { "mason-org/mason.nvim", opts = {} },

  -- ② Mason ↔ lspconfig 桥
  {
    "mason-org/mason-lspconfig.nvim",
    version = "1.*",                 -- ★ 使用1x版本
    opts = {
      ensure_installed = { "pyright", "lua_ls" },
    },
  },

{
  -- ⚡ uv.nvim：自动激活 .venv + UI 选择 + 跑脚本
  "benomahony/uv.nvim",
  event = "VeryLazy",

  opts = {
    auto_activate_venv = true,   -- 进入含 .venv 的项目即自动启用
    picker_integration = true,   -- 用 Telescope/snacks 弹 UI

    -- ★ 动态切换 venv 后，让 Pyright 重启并读取新解释器
    on_activate = function(venv_path)
      -- 1. 关掉旧的 Pyright 客户端
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name == "pyright" then
          client.stop()
        end
      end
      -- 2. 稍等 100 ms，保证 $PATH 已更新，再重新载入当前 buffer
      vim.defer_fn(function() vim.cmd("edit") end, 100)
    end,
  },

  keys = {
    { "<leader>ux", "<cmd>UVInit<CR>",        desc = "uv: init project" },
    { "<leader>ul", "<cmd>UVRunFile<CR>",     desc = "uv: run current file" },
    { "<leader>ue", "<cmd>UVRunSelection<CR>", mode = "v", desc = "uv: run selection" },
    { "<leader>up", "<cmd>UvPicker<CR>",      desc = "uv: command picker (含 venv)" },
  },
},

  -- ③ LSPConfig + 启动器 (重点在这里)
--------------------------------------------------------------------------------
-- LSP 总开关：nvim‑lspconfig + mason‑lspconfig v2.x
--------------------------------------------------------------------------------
{
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  -- Mason 相关插件确保先加载
  dependencies = {
    { "mason-org/mason.nvim",          opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed   = { "pyright", "lua_ls" }, -- 想装别的语言往这里加
        automatic_enable   = true,   -- 打开文件自动 attach
        automatic_installation = true,
      },
    },
  },

  config = function()
    local lspconfig = require("lspconfig")
    local util      = lspconfig.util

    --------------------------------------------------------------------------
    -- ① capabilities：若已装 nvim‑cmp 就带上，否则退回原生
    --------------------------------------------------------------------------
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = ok_cmp and cmp_lsp.default_capabilities()
                           or vim.lsp.protocol.make_client_capabilities()

    --------------------------------------------------------------------------
    -- ② 通用 on_attach：所有语言共享的快捷键
    --------------------------------------------------------------------------
    local function on_attach(_, bufnr)
      local map = function(lhs, rhs)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
      end
      map("gd",          vim.lsp.buf.definition)
      map("gr",          vim.lsp.buf.references)
      map("K",           vim.lsp.buf.hover)
      map("<F2>",        vim.lsp.buf.rename)
      map("<leader>ca",  vim.lsp.buf.code_action)
      map("<leader>dl",  vim.diagnostic.open_float)
    end

    --------------------------------------------------------------------------
    -- ③ Pyright：动态读取当前 VIRTUAL_ENV（来自 uv.nvim）
    --------------------------------------------------------------------------
    local function python_from_venv()
      local venv = vim.env.VIRTUAL_ENV
      if not (venv and #venv > 0) then return nil end
      local sep  = package.config:sub(1,1) == "\\" and "\\" or "/"
      return venv .. sep ..
        (sep == "\\" and "Scripts\\python.exe" or "bin/python")
    end

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach    = on_attach,

      -- ☆ 关键：启动前取当前 venv 的解释器路径
      before_init  = function(_, cfg)
        local py = python_from_venv()
        if py then
          cfg.settings = cfg.settings or {}
          cfg.settings.python = cfg.settings.python or {}
          cfg.settings.python.defaultInterpreterPath = py
        end
      end,

      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths  = true,
            useLibraryCodeForTypes = true,
            diagnosticMode   = "openFilesOnly",
          },
        },
      },
    })

    --------------------------------------------------------------------------
    -- ④ Lua 服务器示例（可按需删改）
    --------------------------------------------------------------------------
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach    = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace   = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    --------------------------------------------------------------------------
    -- ⑤ 其余语言：自动安装 & 自动启用（依靠 mason‑lspconfig 的 automatic_enable）
    --------------------------------------------------------------------------
    -- 不需要写任何代码；打开对应文件即会 attach
  end,
},
}
