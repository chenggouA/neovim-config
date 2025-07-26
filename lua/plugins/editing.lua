
local utils = require("core.utils")
-- 与文本编辑相关的插件
return {
  -- nvim-gomove：通过快捷键移动或复制选中的代码块
  {
    'booperlv/nvim-gomove',
    config = function()
      require('gomove').setup({
        map_defaults = true,        -- 是否启用插件默认按键映射
        reindent = true,            -- 移动后重新缩进
        undojoin = true,            -- 与撤销历史合并
        move_past_end_col = false,  -- 防止移动越过行尾
      })
    end,
  },

  -- nvim-treesitter：基于 Tree-sitter 的语法解析器
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim", -- ✅ 新的彩虹括号插件
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
},

  -- 内置终端插件 toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,                    -- 默认终端高度
        open_mapping = [[<C-\>]],     -- 打开终端的快捷键
        hide_numbers = true,          -- 隐藏行号
        shade_terminals = true,       -- 终端背景加深
        start_in_insert = true,       -- 打开时进入插入模式
        persist_size = true,          -- 记住上次大小
        direction = "horizontal",     -- 默认水平分屏
        close_on_exit = true,         -- 退出时自动关闭
        shell = utils.get_preferred_shell(),          -- 动态选择shell

      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- 终端 1
      local term1 = Terminal:new({ count = 1, direction = "horizontal" })
      vim.keymap.set("n", "<leader>t1", function() term1:toggle() end, { desc = "切换终端 1" })

      -- 终端 2
      local term2 = Terminal:new({ count = 2, direction = "horizontal" })
      vim.keymap.set("n", "<leader>t2", function() term2:toggle() end, { desc = "切换终端 2" })

      -- 浮动终端
      local float_term = Terminal:new({ direction = "float" })
      vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "浮动终端" })

      -- terminal 模式下的常用按键
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
      vim.keymap.set("t", "i", "i", { noremap = true })
      vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:q<CR>", { noremap = true })
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
    end,
  },

{
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      },
    }
  end,
}

}
