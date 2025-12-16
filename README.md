# Neovim 配置

## 项目简介

一套轻量、易扩展的 Neovim 配置，开箱即用，适合日常编码与学习。

## 主要特性与插件

- 🐬 **启动面板**：alpha-nvim 启动界面，海豚 ASCII 艺术，最近项目快速访问
- 🎨 **外观**：One Dark Pro 主题，透明背景支持，which-key 快捷键提示
- 🔧 **开发工具**：LSP (Pyright/clangd/jsonls/marksman/bufls)，智能补全，AI 辅助 (Codeium)
- 📂 **导航**：neo-tree 文件树，Telescope 模糊搜索，Flash 快速跳转，项目管理
- 🐍 **Python 支持**：虚拟环境自动检测与激活，与 Pyright LSP 深度集成
- 🌿 **Git 集成**：gitsigns 状态显示，diffview 可视化 diff 工具
- 🖥️ **终端管理**：toggleterm 多终端支持，自动激活 Python venv
- 📐 **代码折叠**：基于 Tree-sitter 的智能折叠
- 🎯 **快速跳转**：flash.nvim 增强 f/t 跳转，支持可视化标签

详细插件列表请查看：**[PLUGINS.md](PLUGINS.md)**

## 先决条件

- **Neovim** ≥ 0.9
- 推荐安装 [Nerd Fonts](https://www.nerdfonts.com/) 中的 **JetBrainsMono** 字体
- 系统需提供 **C 编译器**（tree-sitter 构建使用）
- **ripgrep** (可选，用于 Telescope 全局搜索)

## 外部依赖

### LSP 服务器与工具（自动安装）

以下 LSP 服务器和格式化工具会通过 **mason-lspconfig** 和 **mason-tool-installer** 在 Neovim 启动时自动安装：

**LSP 服务器**：
- **pyright** (Python)
- **jsonls** (JSON)
- **marksman** (Markdown)
- **bufls** (Protocol Buffers)
- **clangd** (C/C++)

**格式化工具**：
- **stylua** (Lua 格式化)
- **prettier** (Markdown/JSON 格式化)
- **ruff** (Python 格式化与 linter)
- **buf** (Protocol Buffers 格式化)

**注意**：工具会在启动后 3 秒自动检查并安装，也可以通过 `:Mason` 手动管理。

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

## 快捷键速览

> Leader 键：`Space`（空格）

### 常用快捷键

| 快捷键 | 功能 |
|--------|------|
| `<leader>h` | 打开启动面板 |
| `<leader>e` | 打开/聚焦文件树 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索 |
| `<leader>"` | 查看寄存器 |
| `<leader>cf` | 格式化代码 |
| `<leader>cn` | LSP 重命名 |
| `<leader>ca` | 代码操作 |
| `<leader>va` | 激活 Python venv |
| `s` | Flash 快速跳转 |

完整的快捷键速查表请查看：**[KEYMAPS.md](KEYMAPS.md)**

## 常见问题 / 排错

- **tree-sitter 编译失败**：确认已安装 GCC/Clang 等 C 编译器。
- **系统剪贴板未同步**：默认不与系统剪贴板共享，可使用 `<leader>y` 复制、`<leader>p` 粘贴。

## 升级与维护

- 使用 `:Lazy sync` 或 `:Lazy update` 更新插件
- 建议在升级前备份 `lazy-lock.json`

## 许可证与致谢

本项目基于 [MIT 许可证](LICENSE) 开源。
感谢所有开源插件作者的贡献。

