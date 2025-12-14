return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- 设置标题
		dashboard.section.header.val = {
			"",
			"         .--------._",
			"         (`--'       `-.",
			"          `.______      `.",
			"       ___________`__     \\",
			"    ,-'           `-.\\     |",
			"   //                \\|    |\\",
			"  (`  .'~~~~~---\\     \\'   | |",
			"   `-'           )     \\   | |",
			"      ,---------' - -.  `  . '",
			"    ,'             `%`\\`     |",
			"   /                      \\  |",
			"  /     \\-----.         \\    \\",
			" /|  ,_/      '-._        \\   |",
			"(-'  /           /         \\  |",
			",`--<           |        \\  \\ |",
			"\\ |  \\         /%%        \\  \\|",
			" |/   \\____---'--`%        \\  \\",
			" |    '           `         \\  \\",
			" |                           \\  |",
			"  `--.__                      \\ |",
			"        `---._______           \\|",
			"                    `-.         |",
			"                       `._____.'",
			"",
		}

		-- 设置菜单按钮
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  查找文件", ":Telescope find_files <CR>"),
			dashboard.button("a", "󰝒  新建文件", ":ene <BAR> startinsert <CR>"),
			dashboard.button("r", "󰄉  最近文件", ":Telescope oldfiles <CR>"),
			dashboard.button("g", "󰱼  全局搜索", ":Telescope live_grep <CR>"),
			dashboard.button("c", "󰒓  配置", ":e ~/.config/nvim/init.lua <CR>"),
			dashboard.button("l", "󰒲  插件管理", ":Lazy<CR>"),
			dashboard.button("q", "󰩈  退出", ":qa<CR>"),
		}

		-- 设置页脚
		dashboard.section.footer.val = {
			"",
			"    Code is cheap, show me your talk.",
			"",
			"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			"",
		}

		-- 设置布局（调整 padding 让面板居中）
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- 应用配置
		alpha.setup(dashboard.config)

		-- 在进入 alpha buffer 时禁用某些设置
		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			callback = function()
				vim.opt_local.foldenable = false
			end,
		})
	end,
}
