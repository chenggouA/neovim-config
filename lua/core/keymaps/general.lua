local M = {}

function M.setup()
	vim.g.mapleader = " "

	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
	end

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

	-- 折叠相关快捷键（leader z）
	map("n", "<leader>zo", "zR", "展开所有折叠")
	map("n", "<leader>zc", "zM", "折叠所有代码块")
	map("n", "<leader>zt", "za", "切换当前折叠状态")
	map("n", "<leader>zu", "zo", "展开当前折叠")
	map("n", "<leader>zz", "zc", "折叠当前代码块")

	-- Python：一键激活项目 .venv 并重启 Pyright
	map("n", "<leader>va", function()
		require("core.python").activate_project_venv()
	end, "激活项目 .venv 并重启 Pyright")

	-- 类 VSCode 的编辑器历史导航：Alt+Left/Right 后退/前进
	map("n", "<A-Left>", "<C-o>", "返回上一位置")
	map("n", "<A-Right>", "<C-i>", "前进到下一位置")
	-- 兼容部分终端把 Alt 识别为 Meta（M-）
	map("n", "<M-Left>", "<C-o>", "返回上一位置 (M-)")
	map("n", "<M-Right>", "<C-i>", "前进到下一位置 (M-)")
end

return M
