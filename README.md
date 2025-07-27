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

## 自定义按键映射

本配置将空格键设为全局 `<leader>`，以下列出了所有自定义按键：

### 常用操作

- `<leader>e`：切换文件树
- `<leader>bd`：关闭当前 buffer
- `<leader>wd`：关闭当前窗口
- `<leader>wD`：强制关闭窗口
- `<leader>wo`：只保留当前窗口
- `<leader>wq`：退出 Neovim
- `<leader>wQ`：强制退出全部
- `<leader>y`：复制到系统剪贴板
- `<leader>p`：粘贴系统剪贴板

### 终端

- `<C-\>`：打开/关闭终端
- `<leader>t1`：切换终端 1
- `<leader>t2`：切换终端 2
- `<leader>tf`：浮动终端
- 在终端中 `<Esc>` 返回普通模式
- 在终端中 `<C-h>` / `<C-l>` 在窗口间移动

### 文件查找

- `<leader>ff`：查找文件
- `<leader>fg`：全局搜索

### LSP

- `gd`：跳转到定义
- `gr`：查找引用
- `gi`：跳转到实现
- `K`：悬浮文档
- `<leader>rn`：重命名
- `<leader>ca`：代码操作

### 窗口移动与大小调整

- `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>`：在窗口之间移动
- `<A-h>`/`<A-j>`/`<A-k>`/`<A-l>`：调整窗口大小

### nvim-tree

在文件树窗口中可用的快捷键：

- `l`：打开文件或目录
- `h`：收起目录
- `L`：垂直分屏打开
- `S`：水平分屏打开
- `a`：新建
- `r`：重命名
- `d`：删除
- `y`：复制
- `x`：剪切
- `p`：粘贴
- `.`：显示/隐藏隐藏文件
- `R`：刷新
- `q`：关闭文件树
- `<Tab>`：浮动预览
- `gf`：定位当前文件
- `i`：进入当前目录为根
- `u`：回到上级目录

### 自动补全

- `<Tab>`：确认当前建议或跳转到下一个片段
- `<S-Tab>`：跳转到上一个片段
- `<C-j>`：选择下一个建议
- `<C-k>`：选择上一个建议

### 格式化

- `<leader>cf`：立即格式化当前缓冲区

