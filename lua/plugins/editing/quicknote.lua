
return {
  {
    "RutaTang/quicknote.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("quicknote").setup({})

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- 全局笔记
      map("n", "<leader>qg", function()
        require("quicknote").NewNoteAtGlobal()
      end, opts)
      map("n", "<leader>qG", function()
        require("quicknote").OpenNoteAtGlobal()
      end, opts)

      -- 项目 / 当前 CWD 的笔记
      map("n", "<leader>qp", function()
        require("quicknote").NewNoteAtCWD()
      end, opts)
      map("n", "<leader>qP", function()
        require("quicknote").OpenNoteAtCWD()
      end, opts)

      -- 文件/当前 buffer 级笔记（通常与 CWD 相同）
      map("n", "<leader>qf", function()
        require("quicknote").OpenNoteAtCurrentLine()
      end, opts)

      -- 当前行笔记
      map("n", "<leader>ql", function()
        require("quicknote").NewNoteAtCurrentLine()
      end, opts)

      -- 显示/隐藏 当前 buffer 的笔记符号
      map("n", "<leader>qs", function()
        require("quicknote").ToggleNoteSigns()
      end, opts)
      
      -- 跳转到下一个/上一个笔记
      map("n", "]q", function()
        require("quicknote").JumpToNextNote()
      end, opts)
      map("n", "[q", function()
        require("quicknote").JumpToPreviousNote()
      end, opts)
    end,
  },
}
