local M = {}

local neo_utils = require("plugins.navigation.neo_tree_utils")

M.keys = {
    { "<leader>e", neo_utils.open_neotree_project_root, desc = "NeoTree (项目根)" },
}

return M
