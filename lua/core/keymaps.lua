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




local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- 关闭当前窗口 / 强制关闭
map("n", "<leader>wd", "<cmd>close<CR>",    vim.tbl_extend("force", opts, { desc = "关闭当前窗口" }))
map("n", "<leader>wD", "<cmd>close!<CR>",   vim.tbl_extend("force", opts, { desc = "强制关闭窗口" }))
-- 只保留当前窗口
map("n", "<leader>wo", "<cmd>only<CR>",     vim.tbl_extend("force", opts, { desc = "关闭其他窗口" }))
-- 退出 Neovim（写出 \ 保存）
map("n", "<leader>wq", "<cmd>q<CR>",        vim.tbl_extend("force", opts, { desc = "退出 Neovim" }))
map("n", "<leader>wQ", "<cmd>qa!<CR>",      vim.tbl_extend("force", opts, { desc = "强制退出全部" }))
-- 关闭当前缓冲区（
