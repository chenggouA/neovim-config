return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup()
    local ss = require("smart-splits")
    require("core.keymaps.smart_splits").setup(ss)
  end,
}
