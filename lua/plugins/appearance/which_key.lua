return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		win = { border = "rounded" },
		layout = { spacing = 6, align = "center" },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>c", group = "代码操作 💻" },
			{ "<leader>f", group = "Find 🔍" },
			{ "<leader>t", group = "Terminal 🖥️" },
			{ "<leader>b", group = "Buffer 📄" },
			{ "<leader>w", group = "Window ❌" },
			{ "<leader>g", group = "Git ⑂" },
			{ "<leader>m", group = "CMake 🔨" },
			{ "<leader>z", group = "折叠 📐" },
		})
	end,
}
