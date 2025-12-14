local M = {}

local neo_utils = require("plugins.navigation.neo_tree_utils")

M.keys = {
    { "<leader>e", neo_utils.focus_neotree, desc = "文件树" },
}

return M
