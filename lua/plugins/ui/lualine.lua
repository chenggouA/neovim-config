return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function python_env()
      local venv = vim.env.VIRTUAL_ENV
      if venv and venv ~= "" then
        local name = vim.fn.fnamemodify(venv, ":t")
        return "󰌠 " .. name
      end
      return ""
    end
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = "|",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { python_env, "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
