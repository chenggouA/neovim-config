
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })



vim.keymap.set("n", "<leader>q", "<cmd>close<CR>", { desc = "关闭当前窗口" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "强制退出所有窗口" })
vim.keymap.set("n", "<leader>o", "<cmd>only<CR>", { desc = "只保留当前窗口" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "关闭当前 buffer" })


