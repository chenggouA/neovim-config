return {
  {
    "RutaTang/quicknote.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      ----------------------------------------
      -- 初始化
      ----------------------------------------
      require("quicknote").setup({
        sign = "󰓝", -- 可换成你喜欢的 Nerd Font 图标
        -- mode = "portable" 是默认
      })

      require("core.keymaps.quicknote").setup()

      ----------------------------------------
      -- Telescope 扩展
      ----------------------------------------
      pcall(require("telescope").load_extension, "quicknote")
    end,
  },
}
