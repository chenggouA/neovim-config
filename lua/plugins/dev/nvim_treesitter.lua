return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	config = function()
        local os_name = vim.loop.os_uname().sysname

        -- 根据操作系统设置合适的编译器
        local compilers
        if os_name == "Linux" then
            -- Linux系统使用gcc
            compilers = { "gcc" }
        elseif os_name == "Darwin" then
            -- macOS系统使用clang
            compilers = { "clang" }
        else
            -- 其他系统默认使用gcc
            compilers = { "gcc" }
        end 

        -- 应用编译器配置到nvim-treesitter
        require("nvim-treesitter.install").compilers = compilers

        -- 可选：打印当前使用的编译器信息，方便调试
        vim.notify(string.format("nvim-treesitter 将使用以下编译器: %s", table.concat(compilers, ", ")))

		require("nvim-treesitter.install").prefer_git = true

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"bash",
				"python",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"markdown",
				"c",
				"cpp",
				"toml",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
