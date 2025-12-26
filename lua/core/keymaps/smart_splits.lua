local M = {}

function M.setup(ss)
	local map = vim.keymap.set
	map("n", "<C-h>", ss.move_cursor_left)
	map("n", "<C-j>", ss.move_cursor_down)
	map("n", "<C-k>", ss.move_cursor_up)
	map("n", "<C-l>", ss.move_cursor_right)

	-- 窗口大小调整（使用 <leader>r 系列，为标签页释放 <A-hjkl>）
	map("n", "<leader>h", ss.resize_left, { desc = "向左调整" })
	map("n", "<leader>j", ss.resize_down, { desc = "向下调整" })
	map("n", "<leader>k", ss.resize_up, { desc = "向上调整" })
	map("n", "<leader>l", ss.resize_right, { desc = "向右调整" })
end

return M
