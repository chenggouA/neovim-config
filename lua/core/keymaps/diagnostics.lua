local M = {}

function M.setup()
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }
	keymap("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line Diagnostics" }))
	keymap("n", "<leader>ck", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "上一个诊断" }))
	keymap("n", "<leader>cj", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "下一个诊断" }))
	-- keymap("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics List" }))
end

return M
