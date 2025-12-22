return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = require("core.keymaps.aerial").keys,
	cmd = {
		"AerialToggle",
		"AerialOpen",
		"AerialClose",
		"AerialNext",
		"AerialPrev",
		"AerialInfo",
	},
	opts = {
		-- 布局配置
		layout = {
			max_width = { 40, 0.2 }, -- 最大宽度：40 列或 20% 编辑器宽度
			min_width = 20, -- 最小宽度
			default_direction = "prefer_right", -- 优先在右侧打开
			resize_to_content = true, -- 自动调整窗口大小以适应内容
			preserve_equality = true, -- 保持其他窗口的相对大小
		},

		-- 在窗口顶部显示文件路径
		attach_mode = "global",

		-- 后端优先级（TreeSitter > LSP）
		backends = { "treesitter", "lsp", "markdown", "man" },

		-- 延迟加载以提高性能
		lazy_load = true,

		-- 性能优化：大文件禁用
		disable_max_lines = 10000,
		disable_max_size = 2000000, -- 2MB

		-- 符号过滤（只显示主要符号）
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},

		-- 高亮当前符号
		highlight_mode = "split_width",
		highlight_closest = true,
		highlight_on_hover = true,

		-- 图标配置（使用 nvim-web-devicons）
		icons = {},

		-- LSP 配置
		lsp = {
			diagnostics_trigger_update = false,
			update_when_errors = true,
			update_delay = 300,
		},

		-- TreeSitter 配置
		treesitter = {
			update_delay = 300,
		},

		-- 浮动窗口预览配置
		float = {
			border = "rounded",
			relative = "cursor",
			max_height = 20,
			min_height = 4,
		},

		-- 在 aerial 窗口中启用符号导航快捷键
		on_attach = require("core.keymaps.aerial").on_attach,

		-- 关闭时的行为
		close_behavior = "auto",

		-- 显示符号类型的位置
		show_guides = true,
	},
}
