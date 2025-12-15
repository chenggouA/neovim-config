local M = {}

function M.mapping(cmp, luasnip)
	return cmp.mapping.preset.insert({
		-- Tab: 完全由 Codeium 处理
		-- Codeium 会自动处理：
		--   - 有虚拟文本时：接受建议
		--   - 无虚拟文本时：插入 Tab 字符
		-- 这里不定义 Tab，避免与 Codeium 冲突

		-- Enter: 确认补全菜单选中项
		-- select = false 表示只有明确选中的项才会被确认，避免误触
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		-- Ctrl-j/k: 补全菜单中选择上下项
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),

		-- Ctrl-e: 关闭补全菜单
		["<C-e>"] = cmp.mapping.abort(),

		-- Ctrl-b/f: 文档窗口滚动
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Ctrl-Space: 手动触发补全
		["<C-Space>"] = cmp.mapping.complete(),
	})
end

return M
