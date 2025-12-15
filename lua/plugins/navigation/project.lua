return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	config = function()
		require("project_nvim").setup({
			-- 检测项目根目录的模式
			detection_methods = { "lsp", "pattern" },
			-- 用于检测项目的文件/目录
			patterns = { ".git", "pyproject.toml", "package.json", "Makefile", "CMakeLists.txt" },
			-- 是否显示隐藏文件
			show_hidden = false,
			-- 静默 cd（不显示通知）
			silent_chdir = true,
			-- 数据存储路径
			datapath = vim.fn.stdpath("data"),
		})

		-- 与 telescope 集成
		require("telescope").load_extension("projects")
	end,
}
