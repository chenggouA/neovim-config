return {
	"xiyaowong/transparent.nvim",
	config = function()
		require("transparent").setup({
			extra_groups = {
				"NormalFloat",
				"NvimTreeNormal",
				"TelescopeNormal",
			},
			exclude_groups = {},
		})
	end,
}
