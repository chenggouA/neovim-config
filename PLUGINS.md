# 插件列表

本配置使用的所有插件，按功能分类组织。

---

## 外观（Appearance）

### onedarkpro.nvim
**仓库**: `olimorris/onedarkpro.nvim`
**作用**: One Dark 配色方案，提供统一的主题颜色

### lualine.nvim
**仓库**: `nvim-lualine/lualine.nvim`
**作用**: 轻量级状态栏，显示模式、分支、文件名、Python 虚拟环境、编码、文件类型等信息

### mini.nvim
**仓库**: `echasnovski/mini.nvim`
**作用**: 提供图标支持（mini.icons）

### transparent.nvim
**仓库**: `xiyaowong/transparent.nvim`
**作用**: 背景透明化支持，让终端背景透过 Neovim 窗口

### which-key.nvim
**仓库**: `folke/which-key.nvim`
**作用**: 快捷键提示面板，显示可用的键位组合和功能说明

---

## 开发工具（Dev）

### conform.nvim
**仓库**: `stevearc/conform.nvim`
**作用**: 统一代码格式化工具，支持 Lua (stylua)、JSON (jq)、Markdown (prettier)、Python (ruff)

 ## mason.nvim
**仓库**: `mason-org/mason.nvim`
**作用**: LSP 服务器、DAP、Linter、Formatter 的统一管理器

### nvim-gomove
**仓库**: `booperlv/nvim-gomove`
**作用**: 代码块和行的快速移动（支持 Alt+hjkl 移动）

### nvim-treesitter
**仓库**: `nvim-treesitter/nvim-treesitter`
**作用**: 基于 Tree-sitter 的语法高亮、代码解析和折叠支持

### rainbow-delimiters.nvim
**仓库**: `HiPhish/rainbow-delimiters.nvim`
**作用**: 彩虹括号，不同层级的括号显示不同颜色

### cmake-tools.nvim
**仓库**: `Civitasv/cmake-tools.nvim`
**作用**: CMake 项目管理，支持 preset、编译、运行等功能

### nvim-cmp
**仓库**: `hrsh7th/nvim-cmp`
**作用**: 自动补全引擎，整合 LSP、snippet、buffer、path、AI 补全源

### nvim-lspconfig
**仓库**: `neovim/nvim-lspconfig`
**作用**: LSP 客户端配置，支持 Pyright (Python)、clangd (C/C++)、jsonls (JSON)

### tiny-inline-diagnostic.nvim
**仓库**: `rachartier/tiny-inline-diagnostic.nvim`
**作用**: 内联诊断信息显示，使用 ghost 样式替代默认的 virtual text

### windsurf.nvim
**仓库**: `Exafunction/windsurf.nvim`
**作用**: Codeium AI 代码补全，支持虚拟文本（灰色幽灵文字）和补全菜单

---

## 导航（Navigation）

### smart-splits.nvim
**仓库**: `mrjones2014/smart-splits.nvim`
**作用**: 智能窗口分割和导航，支持窗口间平滑跳转和大小调整

### telescope.nvim
**仓库**: `nvim-telescope/telescope.nvim`
**作用**: 模糊搜索工具，用于查找文件、内容、buffer、Git 文件等

### window-picker
**仓库**: `s1n7ax/nvim-window-picker`
**作用**: 窗口选择器，用于在多个窗口中快速选择目标窗口

### neo-tree.nvim
**仓库**: `nvim-neo-tree/neo-tree.nvim`
**作用**: 文件树浏览器，支持文件系统、Git 状态、buffer 管理

---

## 实用工具（Utility）

### auto-save.nvim
**仓库**: `pocco81/auto-save.nvim`
**作用**: 自动保存文件，在 InsertLeave 和文本修改后延迟保存

### toggleterm.nvim
**仓库**: `akinsho/toggleterm.nvim`
**作用**: 终端管理器，支持多终端、浮动终端、自动激活 Python 虚拟环境

### markview.nvim
**仓库**: `OXY2DEV/markview.nvim`
**作用**: Markdown 实时预览和渲染，支持混合模式编辑

---

## Git 集成（Git）

### vim-fugitive
**仓库**: `tpope/vim-fugitive`
**作用**: Git 命令集成，支持 diff、merge、blame 等操作

### gitsigns.nvim
**仓库**: `lewis6991/gitsigns.nvim`
**作用**: Git 状态显示，在行号侧显示修改状态，支持行内 blame

---

## 统计

**总计**: 21 个插件
- 外观: 5 个
- 开发工具: 10 个
- 导航: 4 个
- 实用工具: 3 个
- Git 集成: 2 个
