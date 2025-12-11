local M = {}

-- 聚焦到 Neo-tree 窗口（如果未打开则打开）
function M.focus_neotree()
	vim.cmd("Neotree focus")
end

return M
