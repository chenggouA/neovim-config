return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "left",
				number = false,
				relativenumber = false,
			},
			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
						folder = true,
						file = true,
						folder_arrow = true,
					},
				},
			},
			filters = {
				dotfiles = true,
			},
			git = {
				enable = true,
				ignore = true,
			},
			on_attach = require("core.keymaps.nvimtree").on_attach,
		})
	end,
}
