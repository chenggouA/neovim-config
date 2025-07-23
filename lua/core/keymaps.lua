
-- 设置 <Space> 为 leader 键
-- 习惯性地以 leader 作为自定义快捷键前缀
vim.g.mapleader = " "

-- 打开或关闭文件树插件
-- 按下 <leader>e 即可快速切换 nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件树" })



vim.keymap.set("n", "<leader>q", "<cmd>close<CR>", { desc = "关闭当前窗口" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "强制退出所有窗口" })
vim.keymap.set("n", "<leader>o", "<cmd>only<CR>", { desc = "只保留当前窗口" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "关闭当前 buffer" })


