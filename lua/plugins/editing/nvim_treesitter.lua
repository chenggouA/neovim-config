return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },
  config = function()
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.install").compilers = {}

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "bash", "python", "javascript",
        "typescript", "html", "css", "json", "markdown",
        "c", "cpp", "go", "rust", "toml", "yaml",
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
