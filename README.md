# Neovim 配置

## 项目简介

一套轻量、易扩展的 Neovim 配置，开箱即用，适合日常编码与学习。

## 主要特性与插件

- 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件
- 内置 [tree-sitter](https://tree-sitter.github.io/tree-sitter/) 语法高亮
- [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) 文件树与 Git 视图
- LSP 与自动补全：`nvim-lspconfig`、`nvim-cmp` 等
- 内置终端、文件搜索等增强工具

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

## 快捷键

> Leader 键：`Space`（空格）

完整的快捷键速查表请查看：**[KEYMAPS.md](KEYMAPS.md)**

### 常用快捷键

| 功能 | 快捷键 |
|------|--------|
| 文件树 | `<leader>e` |
| 查找文件 | `<leader>ff` |
| 全局搜索 | `<leader>fg` |
| 新建标签页 | `<A-t>` |
| 切换标签页 | `<A-[>` / `<A-]>` |
| 关闭标签页 | `<A-w>` |
| 跳转定义 | `gd` |
| 格式化代码 | `<leader>cf` |
| 打开终端 | `<C-\>` |
| 保存并退出 | `<leader>wq` |

## 常见问题 / 排错

- **tree-sitter 编译失败**：确认已安装 GCC/Clang 等 C 编译器。
- **系统剪贴板未同步**：默认不与系统剪贴板共享，可使用 `<leader>y` 复制、`<leader>p` 粘贴。

## 升级与维护

- 使用 `:Lazy sync` 或 `:Lazy update` 更新插件
- 建议在升级前备份 `lazy-lock.json`

## 许可证与致谢

本项目基于 [MIT 许可证](LICENSE) 开源。
感谢所有开源插件作者的贡献。

