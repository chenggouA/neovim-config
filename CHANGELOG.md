# Changelog

## 2025-08-13

### Fix: Tree-sitter 折叠在 Python 下无效（no fold found）
- 问题：`foldmethod=expr` 且使用 `nvim_treesitter#foldexpr()` 时，在 Python 文件中无法产生折叠，`<leader>zt`/`zc` 提示 "no fold found"；同时 `zf` 在 expr 模式下本就不可用，造成“无法创建手动折叠”的误解。
- 根因：旧的 `nvim_treesitter#foldexpr()` 在当前环境/版本组合下对部分语言（如 Python）返回 0，未生成折叠。
- 解决：改用 Neovim 内置的 Tree-sitter 折叠接口 `v:lua.vim.treesitter.foldexpr()`。
- 影响范围：所有使用 Tree-sitter 的文件类型获得稳定的折叠行为。

### 变更文件
- `lua/core/options.lua`
  - 将 `opt.foldexpr` 从 `nvim_treesitter#foldexpr()` 更新为 `v:lua.vim.treesitter.foldexpr()`。

### 验证步骤
- 打开 Python 文件，执行：`zx` 然后 `zM`，或使用 `<leader>zc` 折叠、`<leader>zo` 展开、`<leader>zt` 切换。
- 若需手动折叠，请在当前缓冲区临时设置：`:setlocal foldmethod=manual` 后使用 `zf`。
