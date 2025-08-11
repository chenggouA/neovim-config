local M = {}

local neo_utils = require("plugins.navigation.neo_tree_utils")

M.keys = {
    { "<leader>e", neo_utils.toggle_neotree_project_root, desc = "NeoTree 切换 (项目根)" },
}

return M
