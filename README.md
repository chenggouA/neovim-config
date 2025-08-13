# Neovim 配置

## 项目简介

一套轻量、易扩展的 Neovim 配置，开箱即用，适合日常编码与学习。

## 主要特性与插件

- 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件
- 内置 [tree-sitter](https://tree-sitter.github.io/tree-sitter/) 语法高亮
- [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) 文件树与 Git 视图
- LSP 与自动补全：`nvim-lspconfig`、`nvim-cmp` 等
- 内置终端、项目笔记（Quicknote）等增强工具

## 先决条件

- **Neovim** ≥ 0.9
- 推荐安装 [Nerd Fonts](https://www.nerdfonts.com/) 中的 **JetBrainsMono** 字体
- 系统需提供 **C 编译器**（tree-sitter 构建使用）
- 可选格式化器：`stylua`、`ruff`/`ruff-lsp`、`prettier`、`jq`、`ruff-lua`

## 快速上手

1. **克隆仓库**
   - **Linux/macOS**
     ```bash
     git clone <repo> ~/.config/nvim
     ```
   - **Windows**
     ```powershell
     git clone <repo> $Env:LOCALAPPDATA\nvim
     ```
2. **首次启动**
   打开 Neovim，`lazy.nvim` 与所有插件会自动安装。安装完成后即可使用。

## 配置说明

- `init.lua`：入口文件，加载基础选项与插件
- `lua/core/`：核心配置，如选项、工具函数、Python 支持等
- `lua/plugins/`：插件定义与自定义配置

## 快捷键速查表

> 空格键为全局 `<leader>`

### 常用
- `<leader>e`：切换 Neo-tree
- `<leader>bd`：关闭当前 buffer
- `<leader>wq`：退出 Neovim

### 导航
- `<A-Left>` / `<A-Right>`：编辑器历史后退 / 前进（等价 `<C-o>` / `<C-i>`，类 VSCode 体验）

### 窗口与终端
- `<C-h/j/k/l>`：窗口间移动
- `<A-h/j/k/l>`：调整窗口大小
- `<C-\>`：打开/关闭终端
- `<leader>t1`/`<leader>t2`：切换终端 1/2

### 文件与搜索
- `<leader>ff`：查找文件
- `<leader>fg`：全局搜索（依赖 `ripgrep`）

### LSP
- `gd` 跳转到定义
- `gr` 查找引用
- `<leader>rn` 重命名

### 代码操作
- `<leader>ca` 代码操作
- `<leader>cf` 格式化当前缓冲区
- `<leader>cd` 查看当前行诊断

### 折叠
- `<leader>zo`：展开所有折叠（等价 `zR`）
- `<leader>zc`：折叠所有代码块（等价 `zM`）
- `<leader>zt`：切换当前折叠状态（等价 `za`）
- `<leader>zu`：展开当前折叠（等价 `zo`）
- `<leader>zz`：折叠当前代码块（等价 `zc`）
- 提示：默认使用 Tree-sitter 表达式折叠。需要手动折叠时，临时切换当前缓冲区为 `:setlocal foldmethod=manual` 后使用 `zf`。

### 调试（nvim-dap）
- `<F5>`：继续/启动调试（等价 `<leader>dc`）
- `<F10>`：单步跳过（等价 `<leader>dn`）
- `<F11>`：单步进入（等价 `<leader>di`）
- `<S-F11>`：单步跳出（等价 `<leader>do`）
- `<F9>`：切换断点（持久化）
- `<leader>db`：切换断点（持久化）
- `<leader>dB`：条件断点（持久化）
- `<leader>dl`：日志点（持久化）
- `<leader>du`：切换 DAP UI
- `<leader>dp`：打开 DAP REPL
- `<leader>dr`：重启调试会话
- `<leader>dq`：退出调试
- `<leader>de`：评估变量/表达式（在光标处）
- `<leader>dL`：重新读取 `.vscode/launch.json`

### Git
- `<leader>ge`：切换 Git 视图
- `<leader>gd`：打开 Diffview

### Quicknote
- `<leader>qn`：新建当前行笔记
- `<leader>ql`：列出所有笔记

## 常见问题 / 排错

- **tree-sitter 编译失败**：确认已安装 GCC/Clang 等 C 编译器。
- **系统剪贴板未同步**：默认不与系统剪贴板共享，可使用 `<leader>y` 复制、`<leader>p` 粘贴。
- **Alt 方向键无效（tmux）**：在 `~/.tmux.conf` 中加入 `set -g xterm-keys on`，重启 tmux。

## 升级与维护

- 使用 `:Lazy sync` 或 `:Lazy update` 更新插件
- 建议在升级前备份 `lazy-lock.json`

## 许可证与致谢

本项目基于 [MIT 许可证](LICENSE) 开源。
感谢所有开源插件作者的贡献。

