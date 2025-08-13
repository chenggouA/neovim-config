-- LSP、补全等开发体验相关插件
return {
        require("plugins.dev.nvim_gomove"),
        require("plugins.dev.nvim_treesitter"),
        require("plugins.dev.rainbow_delimiters"),
        require("plugins.dev.conform"),
        require("plugins.dev.nvim_cmp"),
        require("plugins.dev.mason"),
        require("plugins.dev.nvim_lspconfig"),
        require("plugins.dev.nvim_dap"),
}
