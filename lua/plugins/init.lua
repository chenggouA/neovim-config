-- 收集并导出所有插件配置表
-- 每个子目录维护一类插件，便于后续按需扩展
-- 通过 merge_tables 将多个模块的列表合并成一个
return require("core.utils").merge_tables(
        require("plugins.appearance"), -- 主题与界面
        require("plugins.dev"), -- 开发相关（LSP、编辑增强等）
        require("plugins.utility"), -- 实用工具
        require("plugins.navigation"), -- 窗口/文件/光标移动
        require("plugins.git") -- Git 集成插件
)
