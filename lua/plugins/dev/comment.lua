return {
	"numToStr/Comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- Treesitter 集成
	},
	config = function()
		require("Comment").setup({
			-- Treesitter 集成（支持 JSX/TSX 等复杂语法）
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
