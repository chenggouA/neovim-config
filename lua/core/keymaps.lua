
-- 设置 <Space> 为 leader 键
-- 习惯性地以 leader 作为自定义快捷键前缀
vim.g.mapleader = " "

-- 打开或关闭文件树插件
-- 按下 <leader>e 即可快速切换 nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件树" })

