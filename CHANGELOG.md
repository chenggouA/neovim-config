- 提取并统一了 Python 虚拟环境相关的函数，新增 `lua/core/python.lua`
- `pyright` 与 `lualine` 插件配置改用上述通用函数
- 通过 `luac -p` 确认变更后的 Lua 文件语法正确

