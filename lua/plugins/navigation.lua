-- 提升窗口与光标移动效率的插件
return {
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      -- 初始化 smart-splits
      require("smart-splits").setup()
      local ss = require("smart-splits")

      -- 键位绑定统一管理
      require("core.keymaps.smart_splits").setup(ss)
    end,
  },



{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = require("core.keymaps.telescope").keys,

  cmd  = "Telescope",       -- 可留可删
  opts = true,              -- 若只是默认配置，留 true 即可；若自定义请写表
  -- config = function() end -- 如果用了 opts，就把 config 删掉
}
}
