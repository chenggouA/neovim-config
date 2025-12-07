return {
	"Civitasv/cmake-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = require("core.keymaps.cmake_tools").keys,
	config = function()
		require("cmake-tools").setup({
			-- 强制使用 preset
			cmake_use_preset = true,

			-- 不允许插件接管构建目录
			cmake_build_directory = "",

			-- 编译数据库由 preset 或选项生成
			cmake_generate_options = {
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
			},

			-- 软链 compile_commands.json
			cmake_soft_link_compile_commands = true,

			-- 使用 toggleterm 作为执行器
			cmake_executor = {
				name = "toggleterm",
				opts = {
					direction = "horizontal",
					size = 15,
				},
			},

			cmake_runner = {
				name = "toggleterm",
				opts = {
					direction = "horizontal",
					size = 15,
				},
			},
		})
	end,
}
