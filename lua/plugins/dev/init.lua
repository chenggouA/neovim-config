-- LSP、补全等开发体验相关插件
return {
	require("plugins.dev.nvim_gomove"),
	require("plugins.dev.nvim_treesitter"),
	require("plugins.dev.rainbow_delimiters"),
	require("plugins.dev.conform"),
	require("plugins.dev.nvim_cmp"),              -- 必须在 windsurf 之前加载
	require("plugins.dev.windsurf"),              -- 必须在 nvim_cmp 之后加载
	require("plugins.dev.mason"),
	require("plugins.dev.nvim_lspconfig"),
	require("plugins.dev.cmake_tools"),
	require("plugins.dev.tiny_inline_diagnostic"),
	require("plugins.dev.comment"),
}
