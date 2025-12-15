local M = {}

function M.mapping(cmp, luasnip)
	return cmp.mapping.preset.insert({
		-- Tab: 仅用于接受 AI 虚拟文本或跳转到下一个 snippet 占位符
		-- 不再用于补全菜单导航，避免与虚拟文本冲突
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				-- 让 Tab 键传递给其他插件（如 Codeium 虚拟文本）
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Enter: 确认补全选项
		-- select = false 表示只有明确选中的项才会被确认，避免误触
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		-- Ctrl-j/k: 补全菜单中选择上下项
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),

		-- Ctrl-b/f: 文档窗口滚动
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Ctrl-Space: 手动触发补全
		["<C-Space>"] = cmp.mapping.complete(),

		-- Ctrl-e: 关闭补全菜单
		["<C-e>"] = cmp.mapping.abort(),
	})
end

return M
