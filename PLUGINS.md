# 插件列表

本配置使用的所有插件，按功能分类组织。

---

## 外观（Appearance）

### alpha-nvim
**仓库**: `goolord/alpha-nvim`
**作用**: 启动面板，显示海豚 ASCII 艺术、快捷操作菜单和名言

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

### nvim-lspconfig
**仓库**: `neovim/nvim-lspconfig`
**作用**: LSP 客户端配置，支持 Pyright (Python)、clangd (C/C++)、jsonls (JSON)、marksman (Markdown)

### mason.nvim
**仓库**: `mason-org/mason.nvim`
**作用**: LSP 服务器、DAP、Linter、Formatter 的统一管理器

### mason-lspconfig.nvim
**仓库**: `williamboman/mason-lspconfig.nvim`
**作用**: mason.nvim 和 nvim-lspconfig 的桥接器，自动安装 LSP 服务器

### mason-tool-installer.nvim
**仓库**: `WhoIsSethDaniel/mason-tool-installer.nvim`
**作用**: 自动安装和管理 formatters、linters 等开发工具（stylua、prettier、jq、ruff、buf）

### schemastore.nvim
**仓库**: `b0o/schemastore.nvim`
**作用**: 提供 JSON schema 支持，为 package.json、tsconfig.json 等文件提供智能补全和验证

### nvim-cmp
**仓库**: `hrsh7th/nvim-cmp`
**作用**: 自动补全引擎，整合 LSP、snippet、buffer、path、AI 补全源

### cmp-nvim-lsp
**仓库**: `hrsh7th/cmp-nvim-lsp`
**作用**: nvim-cmp 的 LSP 补全源

### cmp-buffer
**仓库**: `hrsh7th/cmp-buffer`
**作用**: nvim-cmp 的 buffer 补全源，从当前缓冲区提取关键字

### cmp-path
**仓库**: `hrsh7th/cmp-path`
**作用**: nvim-cmp 的文件路径补全源

### cmp_luasnip
**仓库**: `saadparwaiz1/cmp_luasnip`
**作用**: nvim-cmp 的 LuaSnip 代码片段补全源

### LuaSnip
**仓库**: `L3MON4D3/LuaSnip`
**作用**: 代码片段引擎，支持 VSCode 风格的片段

### friendly-snippets
**仓库**: `rafamadriz/friendly-snippets`
**作用**: 多语言代码片段集合，提供常用的代码模板

### conform.nvim
**仓库**: `stevearc/conform.nvim`
**作用**: 统一代码格式化工具，支持 Lua (stylua)、JSON (jq)、Markdown (prettier)、Python (ruff)、Protocol Buffers (buf)

### nvim-treesitter
**仓库**: `nvim-treesitter/nvim-treesitter`
**作用**: 基于 Tree-sitter 的语法高亮、代码解析和折叠支持

### rainbow-delimiters.nvim
**仓库**: `HiPhish/rainbow-delimiters.nvim`
**作用**: 彩虹括号，不同层级的括号显示不同颜色

### tiny-inline-diagnostic.nvim
**仓库**: `rachartier/tiny-inline-diagnostic.nvim`
**作用**: 内联诊断信息显示，使用 ghost 样式替代默认的 virtual text

### cmake-tools.nvim
**仓库**: `Civitasv/cmake-tools.nvim`
**作用**: CMake 项目管理，支持 preset、编译、运行等功能

### nvim-gomove
**仓库**: `booperlv/nvim-gomove`
**作用**: 代码块和行的快速移动（支持 Alt+hjkl 移动）

### codeium.nvim (windsurf.nvim)
**仓库**: `Exafunction/codeium.nvim`
**作用**: Codeium AI 代码补全，支持虚拟文本（灰色幽灵文字）和补全菜单集成

---

## 导航（Navigation）

### neo-tree.nvim
**仓库**: `nvim-neo-tree/neo-tree.nvim`
**作用**: 文件树浏览器，支持文件系统、Git 状态、buffer 管理

### telescope.nvim
**仓库**: `nvim-telescope/telescope.nvim`
**作用**: 模糊搜索工具，用于查找文件、内容、buffer、寄存器等

### flash.nvim
**仓库**: `folke/flash.nvim`
**作用**: 快速跳转导航插件，通过搜索标签快速跳转到屏幕上的任何位置，增强 f/t/F/T 字符查找

### smart-splits.nvim
**仓库**: `mrjones2014/smart-splits.nvim`
**作用**: 智能窗口分割和导航，支持窗口间平滑跳转和大小调整

### window-picker
**仓库**: `s1n7ax/nvim-window-picker`
**作用**: 窗口选择器，用于在多个窗口中快速选择目标窗口

### project.nvim
**仓库**: `ahmedkhalf/project.nvim`
**作用**: 项目管理插件，自动检测和记录项目（通过 .git、pyproject.toml 等），提供最近项目列表，与启动面板集成

---

## 实用工具（Utility）

### toggleterm.nvim
**仓库**: `akinsho/toggleterm.nvim`
**作用**: 终端管理器，支持多终端、浮动终端、自动激活 Python 虚拟环境

### auto-save.nvim
**仓库**: `pocco81/auto-save.nvim`
**作用**: 自动保存文件，在 InsertLeave 和文本修改后延迟保存

### markview.nvim
**仓库**: `OXY2DEV/markview.nvim`
**作用**: Markdown 实时预览和渲染，支持混合模式编辑

---

## Git 集成（Git）

### gitsigns.nvim
**仓库**: `lewis6991/gitsigns.nvim`
**作用**: Git 状态显示，在行号侧显示修改状态，支持行内 blame

### diffview.nvim
**仓库**: `sindrets/diffview.nvim`
**作用**: 现代化 Git diff 和三路合并工具，提供单标签页界面查看文件差异、提交历史和解决合并冲突

### gitgraph.nvim
**仓库**: `isakbm/gitgraph.nvim`
**作用**: Git 提交图可视化工具，以图形化方式展示分支和提交历史，集成 diffview 查看提交详情

---

## 依赖库（Dependencies）

### plenary.nvim
**仓库**: `nvim-lua/plenary.nvim`
**作用**: Lua 函数库，被 telescope、gitsigns 等多个插件依赖

### nui.nvim
**仓库**: `MunifTanjim/nui.nvim`
**作用**: UI 组件库，被 neo-tree 等插件依赖

### nvim-web-devicons
**仓库**: `nvim-tree/nvim-web-devicons`
**作用**: 文件类型图标支持

---

## 统计

**总计**: 36 个插件
- 外观: 6 个
- 开发工具: 19 个
- 导航: 6 个
- 实用工具: 3 个
- Git 集成: 3 个
- 依赖库: 3 个
