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
		-- 基础 diff 操作
		{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "打开 Diffview" },

		-- 文件历史
		{ "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "当前文件历史" },
		{ "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "整个项目历史" },

		-- 可视模式下查看选中行的演进历史
		{ "<leader>dh", ":'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "选中行的 Git 历史" },
	},
}
