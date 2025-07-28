local M = {}

M.keys = {
    {
        "<leader>cf",
        function()
            require("conform").format({ lsp_fallback = true })
        end,
        desc = "Format buffer",
    },
}

return M
