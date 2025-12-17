return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" }, -- 延迟加载，提升启动速度
	opts = function()
		-- 彩虹配色方案（OneDark 主题色）
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		-- 注册高亮组，每次主题更改时重置
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		return {
			indent = {
				highlight = highlight,
				char = "│", -- 使用细线字符（可选：┊ ┆ ¦ ｜ │）
			},
			scope = {
				enabled = true, -- 启用当前作用域高亮
				show_start = true, -- 显示作用域开始线
				show_end = false, -- 不显示作用域结束线（避免视觉混乱）
			},
			exclude = {
				-- 排除特殊文件类型
				filetypes = {
					"help",
					"alpha",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"toggleterm",
					"TelescopePrompt",
				},
			},
		}
	end,
}
