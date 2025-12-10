return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000, -- 高优先级，确保在其他插件之前加载
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "ghost", -- 使用 ghost 样式（subtle, understated look）
		})

		-- 禁用 Neovim 默认的 virtual_text 和左侧符号列
		vim.diagnostic.config({
			virtual_text = false, -- 关闭默认的行末文本
			signs = false, -- 关闭左侧的 E, W 符号
		})
	end,
}
