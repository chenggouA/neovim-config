return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFileHistory",
	},
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = require("core.keymaps.diffview").keys,
        config = true,
}
