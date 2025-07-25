# Neovim 配置

该仓库提供了一套简洁的 Neovim 配置，主要功能包括：

- 常用编辑增强插件
- 主题与界面优化
- 内置终端与窗口管理

## 使用方法

1. **克隆配置仓库**
   - **Linux/macOS**：
     将仓库克隆到 `~/.config/nvim` 目录
     ```bash
     git clone <repo> ~/.config/nvim
     ```
   - **Windows**：
     将仓库克隆到 `%LOCALAPPDATA%\nvim` 目录
     ```powershell
     git clone <repo> $Env:LOCALAPPDATA\nvim
     ```

2. **准备字体**
   - 推荐安装 [Nerd Fonts](https://www.nerdfonts.com/font-downloads) 中的 **JetBrainsMono** 字体，以确保图标正确显示。

3. **安装 C 编译器**
   - 配置启用了 tree-sitter，需要系统具备 C 编译器。
   - Linux 用户可通过包管理器安装 `gcc` 或 `clang`；Windows 用户可从 [LLVM 发布页](https://github.com/llvm/llvm-project/releases) 获取 `clang`。

4. **启动 Neovim**
   - 首次运行会自动安装 `lazy.nvim` 及所有插件，完成后即可使用。
   - 之后可运行 `:Lazy sync` 来更新插件。

所有配置文件均位于 `lua/` 目录，可根据需要自行修改扩展。

## 剪贴板操作

配置默认不会与系统剪贴板同步，避免 `yy`、`dd` 等命令影响系统剪贴板。
如需复制到系统剪贴板，可在普通或可视模式下使用 `<leader>y`，
粘贴系统剪贴板则可使用 `<leader>p`。
