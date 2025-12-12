-- Flash.nvim - 快速跳转导航插件
-- 通过搜索标签快速跳转到屏幕上的任何位置
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash 跳转",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter 搜索",
		},
		{
			"<c-s>",
			mode = "c",
			function()
				require("flash").toggle()
			end,
			desc = "切换 Flash 搜索",
		},
	},
}
