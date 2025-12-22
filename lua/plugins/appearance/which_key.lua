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
			{ "<leader>a", group = "大纲" },
			{ "<leader>b", group = "标签页" },
			{ "<leader>c", group = "代码" },
			{ "<leader>d", group = "Diff" },
			{ "<leader>f", group = "查找" },
			{ "<leader>g", group = "Git" },
			{ "<leader>m", group = "CMake" },
			{ "<leader>r", group = "调整" },
			{ "<leader>t", group = "终端" },
			{ "<leader>v", group = "Venv" },
			{ "<leader>z", group = "折叠" },

			-- 隐藏数字快捷键（标签页跳转），避免在 which-key 中显示
			{ "<leader>1", hidden = true },
			{ "<leader>2", hidden = true },
			{ "<leader>3", hidden = true },
			{ "<leader>4", hidden = true },
			{ "<leader>5", hidden = true },
			{ "<leader>6", hidden = true },
			{ "<leader>7", hidden = true },
			{ "<leader>8", hidden = true },
			{ "<leader>9", hidden = true },
		})
	end,
}
