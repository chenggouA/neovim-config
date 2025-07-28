return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFileHistory",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git Diff View" },
		{ "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close Diff View" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Git File History" },
		{ "<leader>gH", "<cmd>DiffviewClose<CR>", desc = "Close File History" },
	},
	config = true,
}
