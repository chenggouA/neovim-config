local M = {}

function M.setup()
	vim.g.mapleader = " "

	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
	end

	-- 使用 <leader>y 将选中文本复制到系统剪贴板
	map({ "n", "v" }, "<leader>y", '"+y', "复制到系统剪贴板")

	-- 使用 <leader>p 从系统剪贴板粘贴
	map({ "n", "v" }, "<leader>p", '"+p', "粘贴系统剪贴板")

	-- Normal 和 Visual 模式：H 跳行首（^），L 跳行尾（$）
	map({ "n", "v" }, "H", "^", "Jump to line start (non-blank)")
	map({ "n", "v" }, "L", "$", "Jump to line end")

	-- 折叠快捷键由 nvim-ufo 插件统一管理

	-- Python：一键激活项目 .venv 并重启 Pyright
	map("n", "<leader>va", function()
		require("core.python").activate_project_venv()
	end, "激活项目 .venv 并重启 Pyright")

	-- 历史导航：Leader+方向键 后退/前进
	map("n", "<leader><Left>", "<C-o>", "返回上一位置")
	map("n", "<leader><Right>", "<C-i>", "前进到下一位置")

	-- 标签页管理（Leader b 系列，解决 macOS Neovide 远程连接容器时 Alt 键失效问题）
	map("n", "<leader>bn", "<cmd>tabnew | Alpha<CR>", "新建标签页")
	map("n", "<leader>bc", "<cmd>tabclose<CR>", "关闭当前标签页")
	map("n", "<leader>b<Left>", "<cmd>tabprev<CR>", "上一个标签页")
	map("n", "<leader>b<Right>", "<cmd>tabnext<CR>", "下一个标签页")

	-- 快速跳转到指定标签页（Leader + 1-9，无描述以节省 which-key 空间）
	for i = 1, 9 do
		vim.keymap.set("n", "<leader>" .. i, i .. "gt", { noremap = true, silent = true })
	end
end

return M
