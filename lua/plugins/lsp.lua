-- 语言服务相关插件，可在此扩展
-- ~/.config/nvim/lua/plugins/lsp.lua  (或任何你放 Lazy 列表的文件)
return {

   {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",            -- 首次进入插入模式才加载，零启动负担
    dependencies = {
      -- 2. LSP 补全源
      "hrsh7th/cmp-nvim-lsp",
      -- 3. 其他常用源
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      -- 4. Snippet 引擎
      {
        "L3MON4D3/LuaSnip",
        build = (vim.fn.has("win32") == 1) and nil or "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      },
    },

    config = function()
      ------------------------------------------------------------
      -- 基础设置
      ------------------------------------------------------------
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      -- 预加载社区 snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },

        mapping = cmp.mapping.preset.insert({
          -- <Tab>：确认或跳到下一个占位符
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- <S-Tab>：返回上一个占位
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- <C-Space>：手动触发补全
          ["<A>"] = cmp.mapping.complete(),

    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),

        -- 更贴近 VS Code 的补全外观
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local menus = {
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            }
            vim_item.menu = menus[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  }, -- ① Mason 主体（可空 opts）
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
local lspconfig = require("lspconfig")
local util      = lspconfig.util

-- 取当前虚拟环境里的 python.exe / bin/python
local function python_from_venv()
  local venv = vim.env.VIRTUAL_ENV
  if not (venv and #venv > 0) then return nil end
  local sep = package.config:sub(1,1) == "\\" and "\\" or "/"
  return venv .. sep .. (sep == "\\" and "Scripts\\python.exe" or "bin/python")
end

-- 计算该 venv 的 site‑packages 路径
local function site_packages()
  local venv = vim.env.VIRTUAL_ENV
  if not (venv and #venv > 0) then return nil end
  local sep  = package.config:sub(1,1) == "\\" and "\\" or "/"
  if sep == "\\" then                        -- Windows
    return venv .. "\\Lib\\site-packages"
  else                                       -- Unix/Mac
    -- 用系统 Python 主次版本号拼路径，如 python3.12
    local pyver = vim.version().major .. "." .. vim.version().minor
    return string.format("%s/lib/python%s/site-packages", venv, pyver)
  end
end

-- 通用能力 (如已装 nvim-cmp，则用 cmp 扩展)
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok_cmp and cmp_lsp.default_capabilities()
                     or vim.lsp.protocol.make_client_capabilities()

-- 通用 on_attach：跳转 / 悬浮 / 重命名 / 诊断浮窗
local function on_attach(_, bufnr)
  local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr }) end
  map("gd", vim.lsp.buf.definition)
  map("gr", vim.lsp.buf.references)
  map("K",  vim.lsp.buf.hover)
  map("<F2>",        vim.lsp.buf.rename)
  map("<leader>ca",  vim.lsp.buf.code_action)
  map("<leader>dl",  vim.diagnostic.open_float)
end

-- 真正的 pyright setup
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach    = on_attach,

  -- ☆ 启动前注入解释器路径 & extraPaths
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
        typeCheckingMode        = "basic",
        autoSearchPaths         = true,
        useLibraryCodeForTypes  = true,
        diagnosticMode          = "openFilesOnly",
        -- 如仍想完全屏蔽缺源码波浪线，可解开下一行
        -- diagnosticSeverityOverrides = { reportMissingModuleSource = "none" },
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
