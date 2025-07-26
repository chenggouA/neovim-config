-- 与 Git 相关的插件，可按需自行扩展
return {
  -- 行内改动与 blame

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = { add = { text = "│" }, change = { text = "│" }, delete = { text = "⎺" } },
      current_line_blame = true,       -- :Gitsigns toggle_current_line_blame
    },
  },
}
