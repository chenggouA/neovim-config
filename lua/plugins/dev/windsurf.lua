return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = true, -- 启用 cmp 补全源
			virtual_text = {
				enabled = true, -- 同时启用虚拟文本补全（灰色幽灵文字）
				key_bindings = {
					-- 如果 cmp 菜单未显示，Tab 会接受虚拟文本
					-- 如果 cmp 菜单显示，Tab 会确认 cmp 选项（优先级更高）
					accept = "<Tab>",
					-- 或者你也可以用 Ctrl+Y 单独接受虚拟文本：
					-- accept = "<C-y>",
					next = "<M-]>", -- Alt+] 切换到下一个 AI 建议
					prev = "<M-[>", -- Alt+[ 切换到上一个 AI 建议
					clear = "<C-]>", -- Ctrl+] 清除虚拟文本
				},
			},
		})
	end,
}
