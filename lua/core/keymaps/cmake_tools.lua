local M = {}

M.keys = {
	{ "<leader>mg", "<cmd>CMakeGenerate<CR>", desc = "CMake 生成/配置" },
	{ "<leader>mb", "<cmd>CMakeBuild<CR>", desc = "CMake 构建" },
	{ "<leader>mr", "<cmd>CMakeRun<CR>", desc = "CMake 运行" },
	{ "<leader>mA", "<cmd>CMakeTargetSettings<CR>", desc = "目标设置（参数+环境变量）" },
	{ "<leader>mc", "<cmd>CMakeClean<CR>", desc = "CMake 清理" },
	{ "<leader>mt", "<cmd>CMakeSelectBuildTarget<CR>", desc = "选择构建目标" },
	{ "<leader>ml", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "选择运行目标" },
	{ "<leader>mp", "<cmd>CMakeSelectBuildPreset<CR>", desc = "选择构建预设" },
}

return M
