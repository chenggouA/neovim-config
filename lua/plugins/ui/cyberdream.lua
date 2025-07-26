return {
  "scottmckendry/cyberdream.nvim",
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
    })
    vim.cmd("colorscheme cyberdream")
  end,
}
