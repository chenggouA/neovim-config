local opt = vim.opt

-- 编码设置（必须在最开始设置，确保所有插件正确处理字符）
opt.encoding = "utf-8" -- Neovim 内部编码
opt.fileencoding = "utf-8" -- 新建文件的默认编码
opt.fileencodings = "utf-8,gbk,gb2312,big5" -- 自动检测文件编码顺序

-- 行号设置
-- Normal 模式：相对行号（便于跳转，如 10j）
-- Insert 模式：绝对行号（便于定位具体行）
-- 动态切换由 nvim-numbertoggle 插件自动处理
opt.relativenumber = true -- 默认显示相对行号
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

	-- 透明度设置（0.14.0+ 版本推荐配置）
	vim.g.neovide_opacity = 0.85 -- 窗口不透明度 0~1，可用 Alt+=/- 调整
	-- neovide_background_color 已废弃，移除以避免与 opacity 冲突（macOS 特别重要）
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	-- 性能优化
	vim.g.neovide_refresh_rate = 60 -- 刷新率，配合 --no-vsync 使用
	vim.g.neovide_scroll_animation_length = 0.3 -- 滚动动画时长
	vim.g.neovide_cursor_animation_length = 0.13 -- 光标动画时长

	-- 光标效果
	vim.g.neovide_cursor_trail_size = 0.8 -- 光标轨迹长度 0~1
	vim.g.neovide_cursor_antialiasing = true -- 光标抗锯齿
	vim.g.neovide_cursor_animate_in_insert_mode = true -- 插入模式光标动画
	vim.g.neovide_cursor_animate_command_line = true -- 命令行模式光标动画
	vim.g.neovide_cursor_smooth_blink = true -- 光标平滑闪烁过渡
	vim.g.neovide_cursor_vfx_mode = "torpedo" -- 光标粒子特效：torpedo（鱼雷，更柔和）
	vim.g.neovide_cursor_vfx_particle_lifetime = 0.5 -- 粒子生命周期（降低以减少视觉干扰）
	vim.g.neovide_cursor_vfx_particle_density = 3.0 -- 粒子密度（降低以减少视觉干扰）

	-- 用户体验优化
	vim.g.neovide_input_ime = true -- 支持中文输入法（macOS 重要）
	vim.g.neovide_remember_window_size = true -- 记住窗口大小
	vim.g.neovide_hide_mouse_when_typing = true -- 打字时隐藏鼠标
	vim.g.neovide_window_blurred = true -- 窗口失焦时模糊

	-- macOS 特定优化
	-- 设置 Option 键行为：
	--   "both": 左右 Option 都作为 Meta (Alt) 键，不产生特殊字符
	--   "only_left": 只有左 Option 作为 Meta，右 Option 仍产生特殊字符
	--   "only_right": 只有右 Option 作为 Meta
	--   "none": 两个 Option 都产生特殊字符（macOS 默认行为）
	vim.g.neovide_input_macos_option_key_is_meta = "both" -- 左右 Option 都作为 Meta

	-- 透明度调整函数
	local function change_opacity(delta)
		local current = vim.g.neovide_opacity or 0.7
		local new_opacity = math.max(0.1, math.min(1.0, current + delta))
		vim.g.neovide_opacity = new_opacity
		vim.notify(string.format("透明度: %.0f%%", new_opacity * 100), vim.log.levels.INFO)
	end

	-- 透明度快捷键：Alt+= 增加 / Alt+- 减少 / Alt+0 重置
	vim.keymap.set({ "n", "i" }, "<M-=>", function()
		change_opacity(0.05)
	end, { desc = "增加透明度(更不透明)" })
	vim.keymap.set({ "n", "i" }, "<M-->", function()
		change_opacity(-0.05)
	end, { desc = "减少透明度(更透明)" })
	vim.keymap.set({ "n", "i" }, "<M-0>", function()
		vim.g.neovide_opacity = 0.85
		vim.notify("透明度已重置: 85%", vim.log.levels.INFO)
	end, { desc = "重置透明度" })
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
-- 代码折叠由 nvim-ufo 插件管理，这里只保留基础的 treesitter 折叠表达式
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
