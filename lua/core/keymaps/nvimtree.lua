local M = {}

function M.on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local keymap = vim.keymap.set

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

  keymap("n", "gf", api.tree.find_file, opts("定位当前文件"))

  keymap("n", "i", api.tree.change_root_to_node, opts("进入当前目录为根"))
  keymap("n", "u", api.tree.change_root_to_parent, opts("回到上级目录"))
end

return M
