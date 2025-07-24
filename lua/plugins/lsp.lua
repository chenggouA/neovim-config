-- 语言服务相关插件，可在此扩展
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "跳转到定义")
        map("n", "gr", vim.lsp.buf.references, "查找引用")
        map("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
        map("n", "K", vim.lsp.buf.hover, "悬浮文档")
        map("n", "<leader>rn", vim.lsp.buf.rename, "重命名")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "代码操作")
      end

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "clangd", "lua_ls", "pyright" },
        handlers = {},
      })

      local servers = { "clangd", "lua_ls", "pyright" }

      -- 动态处理每个语言服务
      for _, server in ipairs(servers) do
        if server == "pyright" then
          -- 🔽 仅对 Python 配置虚拟环境路径
          lspconfig.pyright.setup({
            on_attach = on_attach,
            settings = {
              python = {
                venvPath = ".", -- 当前项目目录下寻找虚拟环境
                venv = ".venv", -- 虚拟环境名
                pythonPath = ".venv/Scripts/python.exe", -- Windows 路径
              },
            },
          })
        else
          -- 其他语言默认配置
          lspconfig[server].setup({
            on_attach = on_attach,
          })
        end
      end
    end,
  },
}

