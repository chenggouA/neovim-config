-- 加载核心选项和按键配置
require("core.options")
require("core.keymaps")

-- 设置 lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- 如果路径不存在则自动克隆仓库
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用最新稳定版
    lazypath,
  })
end

-- 将 lazy.nvim 插件加入 runtimepath
vim.opt.rtp:prepend(lazypath)

-- 加载插件配置
require("lazy").setup("plugins")

