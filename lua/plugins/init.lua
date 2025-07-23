
-- 收集并导出所有插件配置表
-- 通过 merge_tables 将多个模块的列表合并成一个
return require('core.utils').merge_tables(
  require("plugins.ui"),        -- 界面相关插件
  require("plugins.lsp"),       -- LSP 与自动补全配置
  require("plugins.editing"),   -- 编辑增强插件
  require("plugins.navigation"),-- 窗口/光标移动相关
  require("plugins.git")        -- Git 集成插件
)

