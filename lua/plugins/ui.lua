-- 与界面和视觉效果相关的插件
return {

    { "scottmckendry/cyberdream.nvim", priority = 1000 ,

  config = function()
    require("cyberdream").setup({
      transparent = false,       -- 如果你想背景透明，可改为 true
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
    })
    vim.cmd("colorscheme cyberdream")
  end,
    },
  

    {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat", "NvimTreeNormal", "TelescopeNormal"
      },
      exclude_groups = {},
    })
  end,
},


  -- 状态栏插件 lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可选：用于显示图标
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight", -- 与主题风格一致
          section_separators = { left = "", right = "" },
          component_separators = "|",
        },
      })
    end,
  },
  -- 文件浏览器 nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 图标支持
    version = "*", -- 使用最新稳定版
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          number = false,
          relativenumber = false,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        -- 自定义按键绑定
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          local keymap = vim.keymap.set

          -- 🌲 Vim 风格推荐按键
          keymap("n", "l", api.node.open.edit, opts("打开"))
          keymap("n", "h", api.node.navigate.parent_close, opts("收起"))
          keymap("n", "L", api.node.open.vertical, opts("垂直分屏打开"))
          keymap("n", "S", api.node.open.horizontal, opts("水平分屏打开"))

          keymap("n", "a", api.fs.create, opts("新建"))
          keymap("n", "r", api.fs.rename, opts("重命名"))
          keymap("n", "d", api.fs.remove, opts("删除"))
          keymap("n", "y", api.fs.copy.node, opts("复制"))
          keymap("n", "x", api.fs.cut, opts("剪切"))
          keymap("n", "p", api.fs.paste, opts("粘贴"))

          keymap("n", ".", api.tree.toggle_hidden_filter, opts("显示/隐藏隐藏文件"))
          keymap("n", "R", api.tree.reload, opts("刷新"))
          keymap("n", "q", api.tree.close, opts("关闭 nvim-tree"))

          keymap("n", "<Tab>", api.node.open.preview, opts("浮动预览"))

          -- 小技巧：定位到当前文件
          keymap("n", "gf", api.tree.find_file, opts("定位当前文件"))

          keymap("n", "i", api.tree.change_root_to_node, opts("进入当前目录为根"))
          keymap("n", "u", api.tree.change_root_to_parent, opts("回到上级目录"))
        end
      })
    end,
  },

 {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        window = {
          border = "rounded",
        },
        layout = {
          spacing = 6,
          align = "center",
        },
      })

      -- ⬇️ 直接在这里注册按键
      local wk = require("which-key")
      wk.register({
        ["<leader>f"] = {
          name = "查找 🔍",
          f = { "<cmd>Telescope find_files<CR>", "查找文件" },
          g = { "<cmd>Telescope live_grep<CR>", "全局搜索" },
        },
        ["<leader>t"] = {
          name = "终端 🖥️",
          f = { "<cmd>ToggleTerm direction=float<CR>", "浮动终端" },
        },
        ["<leader>q"] = {
          name = "窗口 ❌",
          q = { "<cmd>close<CR>", "关闭窗口" },
          Q = { "<cmd>qa!<CR>", "强制退出" },
        },
      })
    end,
  },
}
