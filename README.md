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

3. 安装依赖
   3.1 **安装 C 编译器**
   - 配置启用了 tree-sitter，需要系统具备 C 编译器。
   - Linux 用户可通过包管理器安装 `gcc` 或 `clang`；Windows 用户可从 [LLVM 发布页](https://github.com/llvm/llvm-project/releases) 获取 `clang`。
     3.2 **stylua (可选)**
   - 项目配置了 `lua` 格式化工具，Windows 用户可使用如下命令安装

   ```powershell
   scoop install stylua
   ```

   3.3 **其他格式化器**
   - `ruff` 与 `ruff-lsp`（Python LSP/诊断）

     ```bash
     pip install ruff ruff-lsp
     ```

   - `prettier`（Markdown）

     ```bash
     npm install -g prettier
     ```

   - `jq`（JSON）

     ```bash
     # Debian/Ubuntu
     sudo apt-get install jq
     # macOS
     brew install jq
     # Windows (scoop)
     scoop install jq
     ```

   - `ruff-lua`（额外 Lua 格式化器）

     ```bash
     pip install ruff-lua
     ```

4. **启动 Neovim**
   - 首次运行会自动安装 `lazy.nvim` 及所有插件，完成后即可使用。
   - 之后可运行 `:Lazy sync` 来更新插件。

所有配置文件均位于 `lua/` 目录，可根据需要自行修改扩展。

## 格式化器列表

`conform.nvim` 根据文件类型调用相应的格式化器：

- **Lua**：`stylua`
- **JSON**：`jq`
- **Markdown**：`prettier`
- **额外**：`ruff-lua` 用于 Lua 代码
- （当前未配置 Python 格式化器）

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
- `<leader>fg`：全局搜索(需要依赖`ripgrep`工具)

### LSP

- `gd`：跳转到定义
- `gr`：查找引用
- `gi`：跳转到实现
- `K`：悬浮文档
- `<leader>rn`：重命名

### 代码操作

- `<leader>ca`：代码操作
- `<leader>cd`：显示当前行诊断信息
- `<leader>cf`：立即格式化当前缓冲区
- `<leader>ck`：跳转到上一个诊断
- `<leader>cj`：跳转到下一个诊断

- `<leader>zz`: 折叠当前代码块
- `<leader>zu`: 展开当前代码块
- `<leader>zt`: 切换代码块折叠状态
- `<leader>zc`: 折叠所有代码块
- `<leader>zo`: 展开所有折叠

### 窗口移动与大小调整

- `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>`：在窗口之间移动
- `<A-h>`/`<A-j>`/`<A-k>`/`<A-l>`：调整窗口大小

### nvim-tree

在文件树窗口中可用的快捷键：

- `l`：打开文件或目录
- `h`：收起目录
- `v`：垂直分屏打开
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

### Git

- `<leader>gd`：打开 Diffview
- `<leader>gD`：关闭 Diffview
- `<leader>gh`：查看文件历史
- `<leader>gH`：关闭文件历史

### Quicknote

- `<leader>qn`：新建当前行笔记
- `<leader>qN`：新建并打开项目笔记
- `<leader>qo`：打开当前行笔记
- `<leader>qj`：跳转到下一条笔记
- `<leader>qk`：跳转到上一条笔记
- `<leader>ql`：列出所有笔记
- `<leader>qs`：显示笔记标记
- `<leader>qS`：隐藏笔记标记
- `<leader>qd`：删除当前行笔记
- `<leader>qD`：删除项目笔记
- `<leader>qi`：导入项目笔记
- `<leader>qe`：导出项目笔记

### 自动补全

- `<Tab>`：确认当前建议或跳转到下一个片段
- `<S-Tab>`：跳转到上一个片段
- `<C-j>`：选择下一个建议
- `<C-k>`：选择上一个建议
