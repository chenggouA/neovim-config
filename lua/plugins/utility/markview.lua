return {
	"OXY2DEV/markview.nvim",
	ft = "markdown", -- 只在 Markdown 文件中加载

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("markview").setup({
			-- 模式配置：在哪些模式下显示预览
			modes = { "n", "no", "c" }, -- 普通、操作符待决、命令模式
			hybrid_modes = { "n" }, -- 混合模式（边看边编辑）

			-- 回调函数：进入/离开预览时触发
			callbacks = {
				on_enable = function(_, win)
					vim.wo[win].conceallevel = 2
					vim.wo[win].concealcursor = "c"
				end,
			},
		})
	end,
}
