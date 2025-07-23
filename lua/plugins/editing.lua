return {
{
  'booperlv/nvim-gomove',
  config = function()
    require('gomove').setup {
      map_defaults = true,  -- 使用默认快捷键
      reindent = true,      -- 移动后自动调整缩进
      undojoin = true,      -- 合并为一次撤销操作
      move_past_end_col = false, -- 不允许移出右边界
    }
  end
},

{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "bash", "python", "javascript",
        "typescript", "html", "css", "json", "markdown",
        "c", "cpp", "go", "rust", "toml", "yaml"
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

}
