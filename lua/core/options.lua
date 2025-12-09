local opt = vim.opt

-- 行号设置
-- 同时开启相对行号和绝对行号，
-- 相对行号便于配合数字做跳转，
-- 绝对行号方便精确定位到某一行
opt.relativenumber = true -- 显示相对行号
opt.number = true -- 显示当前行的绝对行号

-- 缩进相关设置
-- 统一使用四个空格缩进，避免 Tab 与空格混用
opt.tabstop = 4 -- 一个 Tab 在编辑时相当于 4 个空格
opt.softtabstop = 4 -- 按下 Tab 键时插入 4 个空格
opt.shiftwidth = 4 -- 使用 >> 或自动缩进时移动 4 个空格
opt.expandtab = true -- 输入的 Tab 转换为空格
opt.smartindent = true -- 根据语法自动判断下一行的缩进
opt.autoindent = true -- 新行默认继承上一行的缩进

-- 其他体验设置
opt.cursorline = true -- 高亮当前行，提升可读性

-- 键位映射超时时间
-- 减少 leader 键延迟，按下空格后等待后续按键的时间（毫秒）
-- 默认值 1000ms 太长，300-500ms 是比较合适的平衡值
opt.timeoutlen = 300 -- 等待按键序列完成的时间
opt.ttimeoutlen = 10 -- 等待键码序列完成的时间（影响 Esc 响应速度）

-- 启用鼠标，便于在终端中拖动和选择文本
opt.mouse:append("a") -- 在所有模式下都支持鼠标操作

-- 外观相关
opt.termguicolors = true -- 开启真彩色，配合主题使用效果更佳
opt.signcolumn = "yes" -- 始终显示左侧的符号列，避免文本跳动

-- Neovide 配置
if vim.g.neovide then
	-- 字体设置
	vim.o.guifont = "JetBrainsMono Nerd Font:h14"

	-- 透明度和背景
	vim.g.neovide_opacity = 0.7 -- 窗口不透明度 0~1，推荐 0.75~0.9
	vim.g.neovide_background_color = "#0f1117" .. string.format("%x", math.floor(255 * 0.8))
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	-- 性能优化
	vim.g.neovide_refresh_rate = 60 -- 刷新率，配合 --no-vsync 使用
	vim.g.neovide_scroll_animation_length = 0.2 -- 滚动动画时长，默认 0.3
	vim.g.neovide_cursor_animation_length = 0.05 -- 光标动画时长，默认 0.13

	-- 光标效果
	vim.g.neovide_cursor_trail_size = 0.8 -- 光标轨迹长度 0~1
	vim.g.neovide_cursor_antialiasing = true -- 光标抗锯齿
	vim.g.neovide_cursor_animate_in_insert_mode = true -- 插入模式光标动画
	vim.g.neovide_cursor_animate_command_line = true -- 命令行模式光标动画
	vim.g.neovide_cursor_smooth_blink = true -- 光标平滑闪烁过渡
	vim.g.neovide_cursor_vfx_mode = "railgun" -- 光标粒子特效：railgun（轨道炮）
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2 -- 粒子生命周期
	vim.g.neovide_cursor_vfx_particle_density = 7.0 -- 粒子密度

	-- 用户体验优化
	vim.g.neovide_input_ime = true -- 支持中文输入法（macOS 重要）
	vim.g.neovide_remember_window_size = true -- 记住窗口大小
	vim.g.neovide_hide_mouse_when_typing = true -- 打字时隐藏鼠标
	vim.g.neovide_window_blurred = true -- 窗口失焦时模糊

	-- macOS 特定优化
	vim.g.neovide_input_macos_option_key_is_meta = "only_left" -- 左 Option 键作为 Meta
end
-- 缩放函数
local function change_font_size(delta)
	-- 解析当前 guifont = "<name>:h<size>"
	local name, size = string.match(vim.o.guifont, "([^:]+):h(%d+)")
	name, size = name or default_font, tonumber(size) or default_size
	size = math.max(size + delta, 6) -- 不让字号小于 6
	vim.o.guifont = string.format("%s:h%d", name, size)
end

-- 快捷键：Ctrl + = / Ctrl + - / Ctrl + 0
local map = vim.keymap.set
for _, mode in ipairs({ "n", "i" }) do
	map(mode, "<C-=>", function()
		change_font_size(1)
	end, { desc = "字体放大" })
	map(mode, "<C-->", function()
		change_font_size(-1)
	end, { desc = "字体缩小" })
	map(mode, "<C-0>", function()
		vim.o.guifont = string.format("%s:h%d", default_font, default_size)
	end, { desc = "恢复默认字号" })
end
-- 默认不与系统剪贴板同步，避免 yy、dd 等操作污染剪贴板
-- 如需从系统剪贴板复制，可使用 <leader>y 等自定义按键
vim.o.clipboard = ""
-- 设置代码折叠
opt.foldmethod = "expr"
-- 使用 Neovim 内置的 Tree-sitter 折叠表达式，避免旧函数在部分语言下无折叠的问题
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false -- 默认不折叠，打开文件时是展开的
opt.foldlevel = 99 -- 打开所有层级
