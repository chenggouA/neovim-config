-- ~/.config/nvim/lua/plugins/git-fugitive.lua
return {
	"tpope/vim-fugitive",
	cmd = { "Git", "Gdiffsplit", "Gvdiffsplit" },
	keys = {
		{ "<leader>gd", ":Gdiffsplit<CR>", desc = "当前文件 diff" },
		{ "<leader>gD", ":Gvdiffsplit!<CR>", desc = "三方 diff" },
	},
}
