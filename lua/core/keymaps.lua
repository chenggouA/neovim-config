-- 设置 <Space> 为 leader 键，方便自定义快捷键
vim.g.mapleader = " "

-- 文件树开关
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件树" })


-- 缓冲区管理
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "关闭当前 buffer" })


-- 使用 <leader>y 将选中文本复制到系统剪贴板
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "复制到系统剪贴板" })

-- 使用 <leader>p 从系统剪贴板粘贴
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "粘贴系统剪贴板" })
