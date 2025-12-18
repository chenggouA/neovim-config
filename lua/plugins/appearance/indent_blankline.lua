return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" }, -- 延迟加载，提升启动速度
	opts = function()
		local hooks = require("ibl.hooks")
		-- 设置 scope 高亮颜色（亮色）
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblScope", {
				fg = "#98C379",  -- OneDark 绿色
				bold = true,      -- 加粗
				underline = true  -- 下划线加粗（配合 show_start）
			})
		end)

		return {
			indent = {
				char = "▏", -- 使用更细的线条字符
			},
			scope = {
				enabled = true,
				show_start = true, -- 显示作用域开始的下划线
				show_end = false,  -- 不显示结束下划线
				highlight = "IblScope",
				char = "▎", -- scope 使用粗线
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
