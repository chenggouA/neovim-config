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
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- 彩虹括号支持
      "p00f/nvim-ts-rainbow",
    },
    config = function()
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
        -- 彩虹括号
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-\>]], -- 默认 Ctrl+\ 切换开关
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal", -- 也可以是 vertical、float、tab
      close_on_exit = true,
      shell = vim.o.shell,
    })

    -- 自定义终端编号
    local Terminal = require("toggleterm.terminal").Terminal

    -- 终端 1
    local term1 = Terminal:new({ count = 1, direction = "horizontal" })
    vim.keymap.set("n", "<leader>1", function() term1:toggle() end, { desc = "切换终端 1" })

    -- 终端 2
    local term2 = Terminal:new({ count = 2, direction = "horizontal" })
    vim.keymap.set("n", "<leader>2", function() term2:toggle() end, { desc = "切换终端 2" })

    -- 浮动终端（独立窗口）
    local float_term = Terminal:new({ direction = "float" })
    vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "浮动终端" })


            -- terminal 模式下退出 insert（进入 normal）
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- normal 模式下重新进入 terminal insert
vim.keymap.set("t", "i", "i", { noremap = true })

-- normal 模式下使用 :q 关闭
    vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:q<CR>", { noremap = true })

            vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

  end,
}




}
