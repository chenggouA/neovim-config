local M = {}

function M.on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  map("n", "gd", vim.lsp.buf.definition, "跳转到定义")
  map("n", "gr", vim.lsp.buf.references, "查找引用")
  map("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
  map("n", "K", vim.lsp.buf.hover, "悬浮文档")
  map("n", "<leader>rn", vim.lsp.buf.rename, "重命名")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "代码操作")
end

return M
