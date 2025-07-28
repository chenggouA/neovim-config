return {
  {
    "RutaTang/quicknote.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      ----------------------------------------
      -- 1. 初始化
      ----------------------------------------
      require("quicknote").setup({
        sign = "󰓝", -- 可换成你喜欢的 Nerd Font 图标
        -- mode = "portable" 是默认
      })

      ----------------------------------------
      -- 2. 快捷键映射
      ----------------------------------------
      local map    = vim.keymap.set
      local opts   = { noremap = true, silent = true }
      local fn     = require("quicknote")
      local prefix = "<leader>q"

      -- 小工具：自动组合 opts + desc
      local function nmap(lhs, rhs, desc)
        map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
      end


      -- A. 新建 / 打开
      nmap(prefix.."n", fn.NewNoteAtCurrentLine,   "新建当前行笔记")
      nmap(prefix.."N", fn.NewNoteAtCWD,    "新建并打开项目笔记")

      nmap(prefix.."o", fn.OpenNoteAtCurrentLine,  "打开当前行笔记")

      -- B. 浏览 / 跳转
      nmap(prefix.."j", fn.JumpToNextNote,         "跳转到下一条笔记")
      nmap(prefix.."k", fn.JumpToPreviousNote,     "跳转到上一条笔记")
      nmap(prefix.."l", "<cmd>Telescope quicknote<CR>", "Telescope 列出笔记")

      -- C. 标记显示开关
      nmap(prefix.."s", fn.ShowNoteSigns,          "显示笔记标记")
      nmap(prefix.."S", fn.HideNoteSigns,          "隐藏笔记标记")

      -- D. 删除 / 清理
      nmap(prefix.."d", fn.DeleteNoteAtCurrentLine,"删除当前行笔记")
      nmap(prefix.."D", fn.DeleteNoteAtCWD,        "删除项目笔记")

      -- E. 导入 / 导出
      nmap(prefix.."i", fn.ImportNotesForCWD,      "导入项目笔记")
      nmap(prefix.."e", fn.ExportNotesForCWD,      "导出项目笔记")

      ----------------------------------------
      -- 3. Telescope 扩展
      ----------------------------------------
      pcall(require("telescope").load_extension, "quicknote")
    end,
  },
}
