- 提取并统一了 Python 虚拟环境相关的函数，新增 `lua/core/python.lua`
- `pyright` 与 `lualine` 插件配置改用上述通用函数
- 通过 `luac -p` 确认变更后的 Lua 文件语法正确

### 2025-08-10
- 优化 `core.python`：
  - `get_venv()` 在缺少 `VIRTUAL_ENV` 时，从 `vim.g.python3_host_prog` 反推出 venv，并校验 `pyvenv.cfg`
  - `site_packages()` 通过调用当前 venv 的 Python 获取真实 `X.Y` 版本，避免路径猜测
  - 新增 `restart_pyright()`，用于切换解释器后重启 Pyright
- 移除 `whichpy.nvim`，改为内置 `.venv` 激活流程：
  - 新增 `core.python.activate_project_venv()`，查找项目根的 `.venv` 并设置 `VIRTUAL_ENV`/`PATH`，随后重启 Pyright
  - 新增快捷键 `<leader>va`：一键激活当前项目 `.venv` 并重启 LSP（见 `lua/core/keymaps/general.lua`）
- 加固 `pyright` 配置：仅在 `site-packages` 目录真实存在时设置 `python.analysis.extraPaths`（`lua/plugins/dev/nvim_lspconfig.lua`）
- 校验：以 headless 方式启动 Neovim，Lua 语法与加载无报错

- 格式化体验
  - Python 格式化改为优先通过 `uvx ruff` 执行（全局安装），若不可用则回退到系统 `ruff`；不再在 `<leader>cf` 自动激活 venv（`lua/plugins/dev/conform.lua` / `lua/core/keymaps/conform.lua`）

