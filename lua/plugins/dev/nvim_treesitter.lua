return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	config = function()
		-- 应用编译器配置到nvim-treesitter
		local function detect_available_compilers()
			local candidates = { "clang", "gcc", "cl" } -- clang优先，最后是 MSVC 的 cl.exe
			local found = {}

			for _, compiler in ipairs(candidates) do
				if vim.fn.executable(compiler) == 1 then
					table.insert(found, compiler)
				end
			end

			return found
		end

		local compilers = detect_available_compilers()
		require("nvim-treesitter.install").compilers = compilers
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
