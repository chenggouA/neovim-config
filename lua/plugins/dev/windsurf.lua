return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		-- 确保编码正确设置（防止 Codeium 处理中文时出错）
		vim.opt.encoding = "utf-8"

		require("codeium").setup({
			enable_cmp_source = true, -- 启用 cmp 补全源（在补全菜单中显示）
			virtual_text = {
				enabled = true, -- 启用虚拟文本补全（灰色内联建议）
				key_bindings = {
					accept = "<Tab>", -- Tab 接受虚拟文本（无虚拟文本时插入 Tab）
					next = "<M-j>", -- Alt+j 切换到下一个 AI 建议
					prev = "<M-k>", -- Alt+k 切换到上一个 AI 建议
					clear = "<M-e>", -- Alt+e 清除虚拟文本
				},
			},
		})
	end,
}
