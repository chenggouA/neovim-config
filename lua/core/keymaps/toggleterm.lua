local M = {}

function M.setup(term1, term2, float_term)
	vim.keymap.set("n", "<leader>t1", function()
		term1:toggle()
	end, { desc = "切换终端 1" })
	vim.keymap.set("n", "<leader>t2", function()
		term2:toggle()
	end, { desc = "切换终端 2" })
	vim.keymap.set("n", "<leader>tf", function()
		float_term:toggle()
	end, { desc = "浮动终端" })

	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
end

return M
