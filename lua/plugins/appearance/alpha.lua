return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "ahmedkhalf/project.nvim" },
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
			dashboard.button("l", "󰒲  插件管理", ":Lazy<CR>"),
			dashboard.button("q", "󰩈  退出", ":qa<CR>"),
		}

		-- 创建最近项目 section
		local function get_recent_projects()
			local projects_section = {
				type = "group",
				val = {},
				opts = { spacing = 0 },
			}

			-- 读取项目历史文件
			local history_file = vim.fn.stdpath("data") .. "/project_nvim/project_history"
			local recent_projects = {}

			if vim.fn.filereadable(history_file) == 1 then
				for line in io.lines(history_file) do
					table.insert(recent_projects, line)
				end
			end

			-- 如果有项目，显示标题
			if #recent_projects > 0 then
				table.insert(projects_section.val, {
					type = "text",
					val = "  最近项目",
					opts = {
						position = "center",
						hl = "AlphaHeader",
					},
				})

				table.insert(projects_section.val, {
					type = "padding",
					val = 1,
				})

				-- 添加最近 5 个项目
				local max_projects = 5
				for i, project_path in ipairs(recent_projects) do
					if i > max_projects then
						break
					end

					-- 提取项目名称（取路径的最后一部分）
					local project_name = vim.fn.fnamemodify(project_path, ":t")
					local display_text = string.format("%d.  %s", i, project_name)

					-- 使用 Lua 函数而不是命令字符串
					local button = dashboard.button(tostring(i), display_text, function()
						-- 切换工作目录
						vim.cmd("cd " .. vim.fn.fnameescape(project_path))
						-- 直接打开 neo-tree 到新目录
						vim.cmd("Neotree close")
						vim.defer_fn(function()
							vim.cmd("Neotree dir=" .. vim.fn.fnameescape(project_path))
						end, 50)
					end)
					button.opts.width = 40
					button.opts.position = "center"

					table.insert(projects_section.val, button)
				end
			else
				-- 如果没有项目，只显示提示（不显示标题）
				table.insert(projects_section.val, {
					type = "text",
					val = "暂无最近项目",
					opts = {
						position = "center",
						hl = "Comment",
					},
				})
			end

			return projects_section
		end

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
			get_recent_projects(),
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

		-- 添加快捷键重新打开启动面板
		vim.keymap.set("n", "<leader>h", function()
			require("alpha").start()
		end, { desc = "打开启动面板", noremap = true, silent = true })
	end,
}
