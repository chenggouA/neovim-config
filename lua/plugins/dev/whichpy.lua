return {
	"neolooong/whichpy.nvim",
	event = { "BufReadPre", "BufNewFile" },

	opts = {
		locator = {
			workspace = {
				enable = true, -- 再打开 workspace 扫描
				patterns = { ".venv" }, -- 只看根下 .venv，速度依旧快
			},
			uv = { enable = true }, -- 保持 uv 打开
		},
	},
	keys = {
		{ "<leader>vp", "<cmd>WhichPy select<CR>", desc = "选择 .venv 解释器" },
		{ "<leader>vr", "<cmd>WhichPy reset<CR>", desc = "重置解释器" },
	},
}
