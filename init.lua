
require("core.options")
require("core.keymaps")



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
		  vim.fn.system({
				      "git",
					      "clone",
						      "--filter=blob:none",
							      "https://github.com/folke/lazy.nvim.git",
								      "--branch=stable", -- 最新稳定版
									      lazypath,
										    })
end

vim.opt.rtp:prepend(lazypath)


-- 加载配置
require("lazy").setup("plugins") 



vim.cmd[[colorscheme tokyonight]]
