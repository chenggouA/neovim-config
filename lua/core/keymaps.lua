-- 设置 <Space> 为 leader 键，方便自定义快捷键
vim.g.mapleader = " "

-- 文件树开关
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件树" })

-- 窗口管理
vim.keymap.set("n", "<leader>q", "<cmd>close<CR>", { desc = "关闭当前窗口" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "强制退出所有窗口" })
vim.keymap.set("n", "<leader>o", "<cmd>only<CR>", { desc = "只保留当前窗口" })

-- 缓冲区管理
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "关闭当前 buffer" })
