--------------------------------------------------------------------------------
-- 统一格式化：isort  →  ruff_format  (Python)
--              stylua               (Lua)
--              jq                   (JSON)
--------------------------------------------------------------------------------

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",

	opts = function()
		local python = require("core.python") -- 你已有的工具
		return {
			-- ★ 保存时自动格式化
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft == "python" or ft == "lua" or ft == "json" then
					return { lsp_fallback = true } -- conform 要求返回 table
				end
			end,

			-- 1. 每种语言对应的 formatter 链
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "jq" },
			},

			-- 2. 每个 formatter 的调用参数
			formatters = {
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
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
}
