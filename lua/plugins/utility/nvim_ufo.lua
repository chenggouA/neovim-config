return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	event = "BufReadPost",

	config = function()
		-- 必需的折叠选项配置
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- 使用默认配置
		require("ufo").setup()
	end,

	keys = {
		-- 全局折叠
		{
			"<leader>zo",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "展开所有折叠",
		},
		{
			"<leader>zc",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "折叠所有代码块",
		},
		-- 当前折叠
		{ "<leader>zz", "za", desc = "切换当前折叠" },
		-- 折叠预览
		{
			"<leader>zp",
			function()
				require("ufo").peekFoldedLinesUnderCursor()
			end,
			desc = "预览折叠内容",
		},
	},
}
