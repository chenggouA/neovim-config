-- Flash.nvim - 快速跳转导航插件
-- 通过搜索标签快速跳转到屏幕上的任何位置
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			treesitter = {
				jump = { autojump = false }, -- 禁用自动跳转,需要手动选择节点
			},
		},
	},
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
			mode = "n",
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
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
