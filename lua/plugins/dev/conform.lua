-------------------------------------------------------------------------------
-- 统一格式化：stylua        (Lua)
--              jq            (JSON)
--              prettier      (Markdown)
--              ruff-lua      (可选 Lua)
-------------------------------------------------------------------------------

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",

	opts = function()
		local python = require("core.python") -- 你已有的工具
		return {

			-- 1. 每种语言对应的 formatter 链
            formatters_by_ft = {
                lua = { "stylua" },
                json = { "jq" },
                markdown = { "prettier" },
                -- Python：使用 Ruff 作为格式化器（先修复再格式化）
                python = { "ruff_fix", "ruff_format" },
            },

			-- 2. 每个 formatter 的调用参数
			formatters = {
				prettier = {
					command = "prettier",
					args = { "--stdin-filepath", "$FILENAME" },
					stdin = true,
				},
				------------------------------------------------------------------
				-- Lua: stylua
				------------------------------------------------------------------
				stylua = {
					command = "stylua",
					args = { "--stdin-filepath", "$FILENAME", "-" },
					stdin = true,
				},

				------------------------------------------------------------------
				-- JSON: jq
				------------------------------------------------------------------
                jq = {
					command = "jq",
					args = { "-M", "." },
					stdin = true,
				},
                ------------------------------------------------------------------
                -- Python: ruff as formatter
                ------------------------------------------------------------------
                ruff_fix = {
                    command = "ruff",
                    args = { "--fix", "-" },
                    stdin = true,
                },
                ruff_format = {
                    command = "ruff",
                    args = { "format", "-" },
                    stdin = true,
                },
			},
		}
	end,

	-- 3. 手动触发
	keys = require("core.keymaps.conform").keys,
}
