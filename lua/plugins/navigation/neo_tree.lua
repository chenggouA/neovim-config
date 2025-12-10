return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},

       keys = require("core.keymaps.neo_tree").keys,
	-- 只保留 config，不再写 opts
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = false,

			-- ✨ 统一窗口设置
			window = {
				position = "left",
				width = 30,
				mappings = {
					-- ── 迁移自 nvim-tree ──
					["l"] = "open", -- 打开
					["h"] = "close_node", -- 收起
					["v"] = "open_vsplit", -- 垂直分屏
					["a"] = "add", -- 新建
					["r"] = "rename", -- 重命名
					["d"] = "delete", -- 删除
					["y"] = "copy_to_clipboard", -- 复制
					["x"] = "cut_to_clipboard", -- 剪切
					["p"] = "paste_from_clipboard", -- 粘贴
					["R"] = "refresh", -- 刷新
					["q"] = "close_window", -- 关闭侧边栏
					["<Tab>"] = "preview", -- 预览
					["i"] = "set_root", -- 设为根目录
					["u"] = "navigate_up", -- 回到上级
				},
			},

			-- ✨ 文件系统设置
			filesystem = {
                bind_to_cwd = false,   
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
				},
			},

			-- ✨ Git 视图
			sources = { "filesystem", "git_status" },
			git_status = {
				window = { position = "left", width = 30 },
			},

			-- ✨ Git 符号（ASCII 简洁版）
			default_component_configs = {
				git_status = {
					align = "right",
					symbols = {
						added = "+",
						modified = "~",
						removed = "-",
						renamed = ">",
						untracked = "?",
						ignored = "i",
						staged = "✔",
						conflict = "!",
						unstaged = "?",
					},
				},
			},
		})

		-- VSCode 风格的 Git 文件状态配色
		vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#73C991" })  -- 绿色（未追踪）
		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#E5C07B" })   -- 黄色（修改）
		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#98C379" })      -- 亮绿（新增）
		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#E06C75" })    -- 红色（删除）
		vim.api.nvim_set_hl(0, "NeoTreeGitRenamed", { fg = "#61AFEF" })    -- 蓝色（重命名）
		vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#E06C75" })   -- 红色（冲突）
		vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#5C6370" })    -- 灰色（忽略）
		vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#98C379" })     -- 绿色（暂存）
	end,
}
