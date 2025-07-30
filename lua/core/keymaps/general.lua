local M = {}
function M.setup()
	vim.g.mapleader = " "

	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
	end

	-- 文件树开关
	map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "切换文件树")

	-- 缓冲区管理
	map("n", "<leader>bd", "<cmd>bdelete<CR>", "关闭当前 buffer")

	-- 使用 <leader>y 将选中文本复制到系统剪贴板
	map({ "n", "v" }, "<leader>y", '"+y', "复制到系统剪贴板")

	-- 使用 <leader>p 从系统剪贴板粘贴
	map({ "n", "v" }, "<leader>p", '"+p', "粘贴系统剪贴板")

	-- Normal 和 Visual 模式：H 跳行首（^），L 跳行尾（$）
	map({ "n", "v" }, "H", "^", "Jump to line start (non-blank)")
	map({ "n", "v" }, "L", "$", "Jump to line end")

	-- 关闭当前窗口 / 强制关闭
	map("n", "<leader>wd", "<cmd>close<CR>", "关闭当前窗口")
	map("n", "<leader>wD", "<cmd>close!<CR>", "强制关闭窗口")

	-- 只保留当前窗口
	map("n", "<leader>wo", "<cmd>only<CR>", "关闭其他窗口")

	-- 退出 Neovim（写出 \ 保存）
	map("n", "<leader>wq", "<cmd>q<CR>", "退出 Neovim")
	map("n", "<leader>wQ", "<cmd>qa!<CR>", "强制退出全部")
end

return M
