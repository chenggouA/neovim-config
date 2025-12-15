-- gitgraph.nvim: 在 Neovim 中显示美观的 Git 提交图
return {
    "isakbm/gitgraph.nvim",
    dependencies = {
        "sindrets/diffview.nvim",
    },
    opts = {
        hooks = {
            -- 集成 diffview.nvim 查看提交详情
            on_select_commit = function(commit)
                vim.notify("DiffviewOpen " .. commit.hash .. "^!")
                vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
            end,
            on_select_range_commit = function(from, to)
                vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
            end,
        },
    },
    keys = {
        {
            "<leader>gg",
            function()
                require("gitgraph").draw({}, { all = true, max_count = 5000 })
            end,
            desc = "Git Graph (提交图)",
        },
    },
}
