-- 与文本编辑相关的插件
return {

  -- nvim-gomove：通过快捷键移动或复制选中的代码块
  {
    'booperlv/nvim-gomove',
    config = function()
      require('gomove').setup {
        map_defaults = true,        -- 是否启用插件自带的默认按键
        reindent = true,            -- 移动后重新对齐缩进，保持代码整洁
        undojoin = true,            -- 将一次移动视为一次撤销步骤
        move_past_end_col = false,  -- 防止移动时越过行尾
      }
    end
  },

  -- nvim-treesitter：基于 Tree-sitter 的语法解析器
  -- 提供更加精准的高亮与代码折叠功能
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",             -- 安装或更新后自动编译语法树
    event = { "BufReadPost", "BufNewFile" }, -- 打开文件时再加载，提高启动速度
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- 常用语言的语法解析器
          "lua", "vim", "bash", "python", "javascript",
          "typescript", "html", "css", "json", "markdown",
          "c", "cpp", "go", "rust", "toml", "yaml"
        },
        highlight = {
          enable = true,                -- 启用基于 Tree-sitter 的语法高亮
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,                -- 让 Tree-sitter 协助处理缩进
        },
      })
    end,
  }

}
