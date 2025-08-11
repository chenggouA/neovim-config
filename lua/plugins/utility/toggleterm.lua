local utils = require("core.utils")

-- 计算应作为终端 cwd 的目录：优先取 neo-tree 的当前根目录，其次项目根，最后当前工作目录
local function resolve_desired_cwd()
  -- 1) 优先从 neo-tree 的 filesystem 源的状态获取根目录
  local ok_manager, manager = pcall(require, "neo-tree.sources.manager")
  if ok_manager and manager and type(manager.get_state) == "function" then
    local state = manager.get_state("filesystem")
    if state then
      local path = state.path or state.cwd
      if type(path) == "string" and path ~= "" then
        return path
      end
      if state.tree and state.tree.root and state.tree.root.path then
        return state.tree.root.path
      end
    end
  end

  -- 2) 回退：根据当前 buffer 计算项目根
  local file = vim.api.nvim_buf_get_name(0)
  if file ~= "" then
    local root = vim.fs.root(file, {
      ".git",
      ".hg",
      "pyproject.toml",
      "package.json",
      "go.mod",
      "Cargo.toml",
      "Makefile",
    })
    if root and root ~= "" then
      return root
    end
    return vim.fn.fnamemodify(file, ":p:h")
  end

  -- 3) 兜底：当前工作目录
  return vim.loop.cwd()
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      -- 禁用插件默认的 <C-\> 映射，改为自定义以在打开前设置 cwd
      -- open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = utils.get_preferred_shell(),
    })

    local Terminal = require("toggleterm.terminal").Terminal

    -- 使用函数式 dir，使每次打开时动态解析 cwd
    local term1 = Terminal:new({ count = 1, direction = "horizontal", dir = resolve_desired_cwd })
    local term2 = Terminal:new({ count = 2, direction = "horizontal", dir = resolve_desired_cwd })
    local float_term = Terminal:new({ direction = "float", dir = resolve_desired_cwd })

    -- 若外部键位模块不存在，则在此处设置合理的默认键位
    local ok_keys, keys_mod = pcall(require, "core.keymaps.toggleterm")
    if ok_keys and keys_mod and type(keys_mod.setup) == "function" then
      keys_mod.setup(term1, term2, float_term)
    else
      local map_opts = { noremap = true, silent = true, desc = "ToggleTerm (neo-tree 根目录)" }
      -- Normal / Terminal 模式均可用
      vim.keymap.set({ "n", "t" }, "<C-\\>", function()
        -- 保守起见，打开前再刷新一次 dir
        term1.dir = resolve_desired_cwd
        term1:toggle()
      end, map_opts)

      -- 额外提供两个可选终端
      vim.keymap.set({ "n", "t" }, "<leader>t2", function()
        term2.dir = resolve_desired_cwd
        term2:toggle()
      end, { noremap = true, silent = true, desc = "ToggleTerm #2 (neo-tree 根目录)" })

      vim.keymap.set({ "n", "t" }, "<leader>tf", function()
        float_term.dir = resolve_desired_cwd
        float_term:toggle()
      end, { noremap = true, silent = true, desc = "ToggleTerm 浮窗 (neo-tree 根目录)" })
    end
  end,
}
