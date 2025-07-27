 
--------------------------------------------------------------------------------
-- 统一格式化：isort  →  ruff_format  (Python)
--              stylua               (Lua)
--              jq                   (JSON)
--------------------------------------------------------------------------------
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",      -- 写入前懒加载

  opts = function()
    return {
      -- ★ 保存时自动格式化：仅限指定 filetype
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "python" or ft == "lua" or ft == "json" then
          -- conform 要求返回 *table* 或 nil；这里也顺便启用 LSP fallback
          return { lsp_fallback = true }
        end
      end,

      --------------------------------------------------------------------------
      -- 1. 不同语言对应的 formatter 链（顺序 = 执行顺序）
      --------------------------------------------------------------------------
      formatters_by_ft = {
        python = { "isort", "ruff_format" }, -- 先 isort，再 Ruff Black‑style
        lua    = { "stylua" },
        json   = { "jq" },
      },

      --------------------------------------------------------------------------
      -- 2. 每个 formatter 的调用细节
      --    command 会在 (vim.env.PATH) 中查找，可直接用 .venv\Scripts 下的 exe
      --------------------------------------------------------------------------
      formatters = {
        ------------------------------------------------------------------------
        -- Python: isort
        ------------------------------------------------------------------------
        isort = {
          command = "isort",                          -- 依赖  .venv\Scripts\isort.exe
          args    = { "--stdout", "--profile", "black", "-" },
          stdin   = true,
        },

        ------------------------------------------------------------------------
        -- Python: Ruff 格式化 (Black 风格)
        ------------------------------------------------------------------------
        ruff_format = {
          command = "ruff",                           -- 依赖  .venv\Scripts\ruff.exe
          args    = { "format", "-" },
          stdin   = true,
        },

        ------------------------------------------------------------------------
        -- Lua: stylua
        ------------------------------------------------------------------------
        stylua = {
          command = "stylua",
          args    = { "--stdin-filepath", "$FILENAME", "-" },
          stdin   = true,
        },

        ------------------------------------------------------------------------
        -- JSON: jq
        ------------------------------------------------------------------------
        jq = {
          command = "jq",
          args    = { "-M", "." },
          stdin   = true,
        },
      },
    }
  end,

  -- 3. 手动触发：<leader>cf  立即格式化当前缓冲区
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ lsp_fallback = true }) end,
      desc = "Format buffer",
    },
  },
}
