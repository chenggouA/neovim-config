return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		win = { border = "rounded" },
		layout = { spacing = 6, align = "center" },
		icons = {
			mappings = false, -- 禁用自动图标
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			-- 键位组
			{ "<leader>c", group = "代码" },
			{ "<leader>d", group = "Diff" },
			{ "<leader>f", group = "查找" },
			{ "<leader>g", group = "Git" },
			{ "<leader>m", group = "CMake" },
			{ "<leader>r", group = "调整" },
			{ "<leader>t", group = "终端" },
			{ "<leader>v", group = "Venv" },
			{ "<leader>z", group = "折叠" },
		})
	end,
}
