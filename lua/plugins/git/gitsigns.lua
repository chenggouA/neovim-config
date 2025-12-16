return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = true, -- 显示当前行的 Git blame 信息

		-- 配置 Git 状态符号并启用行数显示
		signs = {
			add          = { text = '┃', show_count = true },
			change       = { text = '┃', show_count = true },
			delete       = { text = '▁', show_count = true },
			topdelete    = { text = '▔', show_count = true },
			changedelete = { text = '~', show_count = true },
			untracked    = { text = '┆', show_count = false }, -- 未跟踪文件不显示计数
		},

		-- 使用下标数字显示行数（更美观）
		count_chars = {
			[1] = '₁', [2] = '₂', [3] = '₃', [4] = '₄', [5] = '₅',
			[6] = '₆', [7] = '₇', [8] = '₈', [9] = '₉',
			['+'] = '₊', -- 超过 9 行时显示
		},
	},
}
