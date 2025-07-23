
-- 收集并导出所有插件
return require('core.utils').merge_tables(
  require("plugins.ui"),
  require("plugins.lsp"),
  require("plugins.editing"),
  require("plugins.navigation"),
  require("plugins.git")
)

