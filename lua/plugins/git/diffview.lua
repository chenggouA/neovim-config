-- diffview.nvim: 单标签页 Git diff 和三路合并工具
return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
	},
	opts = {
		-- 官方推荐：PR review 时默认使用 --imply-local
		-- 这样 diff 的右侧会显示工作树版本，支持 LSP
		default_args = {
			DiffviewOpen = { "--imply-local" },
		},
	},
	keys = {
		-- Git diff 操作
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff (当前改动)" },

		-- Git 文件历史
		{ "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Git 文件历史" },
		{ "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Git 完整历史" },

		-- 可视模式下查看选中行的演进历史
		{ "<leader>gf", ":'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Git 选中行历史" },
	},
}
