local opt = vim.opt


-- 行号

opt.relativenumber = true
opt.number = true


-- 缩进
opt.tabstop = 4        -- 一个Tab显示为4个空格
opt.softtabstop = 4    -- 编辑时按Tab插入4个空格
opt.shiftwidth = 4     -- 自动缩进时使用4个空格
opt.expandtab = true   -- 将Tab转换为空格
opt.smartindent = true -- 自动检测代码块，智能缩进
opt.autoindent = true  -- 延续前一行的缩进

		


opt.cursorline = true



-- 启用鼠标
opt.mouse:append("a")




-- 外观

opt.termguicolors = true
opt.signcolumn = "yes"
