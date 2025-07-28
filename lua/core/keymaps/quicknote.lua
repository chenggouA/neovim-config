local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local fn = require("quicknote")
  local prefix = "<leader>q"

  local function nmap(lhs, rhs, desc)
    map("n", prefix .. lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  -- A. 新建 / 打开
  nmap("n", fn.NewNoteAtCurrentLine, "新建当前行笔记")
  nmap("N", fn.NewNoteAtCWD, "新建并打开项目笔记")
  nmap("o", fn.OpenNoteAtCurrentLine, "打开当前行笔记")

  -- B. 浏览 / 跳转
  nmap("j", fn.JumpToNextNote, "跳转到下一条笔记")
  nmap("k", fn.JumpToPreviousNote, "跳转到上一条笔记")
  nmap("l", "<cmd>Telescope quicknote<CR>", "Telescope 列出笔记")

  -- C. 标记显示开关
  nmap("s", fn.ShowNoteSigns, "显示笔记标记")
  nmap("S", fn.HideNoteSigns, "隐藏笔记标记")

  -- D. 删除 / 清理
  nmap("d", fn.DeleteNoteAtCurrentLine, "删除当前行笔记")
  nmap("D", fn.DeleteNoteAtCWD, "删除项目笔记")

  -- E. 导入 / 导出
  nmap("i", fn.ImportNotesForCWD, "导入项目笔记")
  nmap("e", fn.ExportNotesForCWD, "导出项目笔记")
end

return M
