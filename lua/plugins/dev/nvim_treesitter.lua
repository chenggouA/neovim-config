return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master", -- 官方要求指定 master 分支
	build = ":TSUpdate",
	lazy = false, -- nvim-treesitter does not support lazy-loading
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	config = function()
		-- 应用编译器配置到nvim-treesitter
		local function detect_available_compilers()
			-- 检测 C/C++ 编译器对
			-- 优先级: clang/clang++ > gcc/g++ > cl (MSVC)
			local compiler_pairs = {
				{ c = "clang", cpp = "clang++" },
				{ c = "gcc", cpp = "g++" },
				{ c = "cl", cpp = "cl" },
			}

			for _, pair in ipairs(compiler_pairs) do
				if vim.fn.executable(pair.c) == 1 then
					-- 找到可用的 C 编译器,返回 C 和 C++ 编译器
					local compilers = { pair.c }
					if vim.fn.executable(pair.cpp) == 1 then
						table.insert(compilers, pair.cpp)
					end
					return compilers
				end
			end

			return {} -- 没有找到任何编译器
		end

		local compilers = detect_available_compilers()
		if #compilers > 0 then
			require("nvim-treesitter.install").compilers = compilers
			vim.notify(string.format("nvim-treesitter 将使用以下编译器: %s", table.concat(compilers, ", ")))
		else
			vim.notify("警告: 未找到 C/C++ 编译器,nvim-treesitter 可能无法编译解析器", vim.log.levels.WARN)
		end

		-- 配置 nvim-treesitter
		require("nvim-treesitter.configs").setup({
			-- 自动安装这些语言的解析器
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"bash",
				"python",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"markdown",
				"markdown_inline",
				"cpp",
				"toml",
				"yaml",
			},
			-- 异步安装(推荐)
			sync_install = false,
			-- 打开文件时自动安装缺失的解析器
			auto_install = true,
			-- 语法高亮模块
			highlight = {
				enable = true,
				-- 不使用额外的 vim 正则高亮(提高性能)
				additional_vim_regex_highlighting = false,
			},
			-- 缩进模块(实验性)
			indent = {
				enable = true,
			},
		})
	end,
}
