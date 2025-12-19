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

		-- 配置 nvim-ufo，排除 neo-tree 等特殊 buffer
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				-- 在 neo-tree 等特殊 buffer 中禁用折叠
				if filetype == "neo-tree" or filetype == "" or buftype ~= "" then
					return ""
				end
				return { "treesitter", "indent" }
			end,
		})
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
