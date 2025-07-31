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
			-- ★ 保存时自动格式化
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft == "python" or ft == "lua" or ft == "json" or ft == "markdown" then
					return { lsp_fallback = true } -- conform 要求返回 table
				end
			end,

			-- 1. 每种语言对应的 formatter 链
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "jq" },
				markdown = { "prettier" },
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
			},
		}
	end,

	-- 3. 手动触发
	keys = require("core.keymaps.conform").keys,
}
