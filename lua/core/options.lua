local opt = vim.opt

-- 行号设置
-- 同时开启相对行号和绝对行号，
-- 相对行号便于配合数字做跳转，
-- 绝对行号方便精确定位到某一行
opt.relativenumber = true   -- 显示相对行号
opt.number = true           -- 显示当前行的绝对行号

-- 缩进相关设置
-- 统一使用四个空格缩进，避免 Tab 与空格混用
opt.tabstop = 4             -- 一个 Tab 在编辑时相当于 4 个空格
opt.softtabstop = 4         -- 按下 Tab 键时插入 4 个空格
opt.shiftwidth = 4          -- 使用 >> 或自动缩进时移动 4 个空格
opt.expandtab = true        -- 输入的 Tab 转换为空格
opt.smartindent = true      -- 根据语法自动判断下一行的缩进
opt.autoindent = true       -- 新行默认继承上一行的缩进

-- 其他体验设置
opt.cursorline = true       -- 高亮当前行，提升可读性

-- 启用鼠标，便于在终端中拖动和选择文本
opt.mouse:append("a")       -- 在所有模式下都支持鼠标操作

-- 外观相关
opt.termguicolors = true    -- 开启真彩色，配合主题使用效果更佳
opt.signcolumn = "yes"      -- 始终显示左侧的符号列，避免文本跳动

-- 设置字体
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end


-- 启动系统剪切板支持
vim.o.clipboard = "unnamedplus"
