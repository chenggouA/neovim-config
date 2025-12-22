local M = {}

M.keys = {
	{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "切换代码大纲" },
}

-- 在 aerial 窗口中使用的快捷键（通过 on_attach 配置）
M.on_attach = function(bufnr)
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
	end

	map("n", "{", "<cmd>AerialPrev<CR>", "上一个符号")
	map("n", "}", "<cmd>AerialNext<CR>", "下一个符号")
	map("n", "[[", "<cmd>AerialPrevUp<CR>", "上一个父级符号")
	map("n", "]]", "<cmd>AerialNextUp<CR>", "下一个父级符号")
end

return M
