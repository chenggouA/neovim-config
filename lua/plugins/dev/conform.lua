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
		return {

			-- 1. 每种语言对应的 formatter 链
            formatters_by_ft = {
                lua = { "stylua" },
                json = { "jq" },
                markdown = { "prettier" },
                -- Python：优先使用 uvx 的全局 ruff；若无则退回系统 ruff
                -- 顺序：fix -> format
                python = { "ruff_uvx_fix", "ruff_fix", "ruff_uvx_format", "ruff_format" },
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
                -- Python: ruff as formatter (uvx 优先)
                ------------------------------------------------------------------
				ruff_uvx_fix = {
                    command = "uvx",
                    args = { "ruff", "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                    condition = function()
                        return vim.fn.executable("uvx") == 1
                    end,
                },
				ruff_fix = {
                    command = "ruff",
                    args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                    condition = function()
                        return vim.fn.executable("ruff") == 1
                    end,
                },
				ruff_uvx_format = {
                    command = "uvx",
                    args = { "ruff", "format", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                    condition = function()
                        return vim.fn.executable("uvx") == 1
                    end,
                },
				ruff_format = {
                    command = "ruff",
                    args = { "format", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                    condition = function()
                        return vim.fn.executable("ruff") == 1
                    end,
                },
			},
		}
	end,

	-- 3. 手动触发
	keys = require("core.keymaps.conform").keys,
}
