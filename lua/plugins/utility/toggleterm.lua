local utils = require("core.utils")

-- 解析合适的工作目录（优先 neo-tree 当前根目录）
local function resolve_desired_cwd()
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

  return vim.loop.cwd()
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
    require("toggleterm").setup({
			size = 15,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
            shell = utils.get_preferred_shell(),
		})

		local Terminal = require("toggleterm.terminal").Terminal
        local function with_on_open(term)
            term.on_open = function(t)
                local python = require("core.python")
                local cmd = python.activation_command()
                if cmd and cmd ~= "" then
                    t:send(cmd)
                    t:send("\r")
                end
            end
            return term
        end

        local term1 = with_on_open(Terminal:new({ count = 1, direction = "horizontal" }))
        local term2 = with_on_open(Terminal:new({ count = 2, direction = "horizontal" }))
        local float_term = with_on_open(Terminal:new({ direction = "float" }))

        -- 统一包装一个带 cwd 校准的切换函数
        local function toggle_with_cwd(term, size, direction)
          term.dir = resolve_desired_cwd()
          term:toggle(size, direction)
        end

        -- 使用原有的外部键位模块，随后用相同按键覆盖，确保目录正确
        local ok_keys, keys_mod = pcall(require, "core.keymaps.toggleterm")
        if ok_keys and keys_mod and type(keys_mod.setup) == "function" then
          keys_mod.setup(term1, term2, float_term)
        end

        -- 覆盖/补充键位：打开前设置到 neo-tree 根目录
        vim.keymap.set("n", "<leader>t1", function()
          toggle_with_cwd(term1)
        end, { desc = "切换终端 1（跟随 neo-tree 根）" })

        vim.keymap.set("n", "<leader>t2", function()
          toggle_with_cwd(term2)
        end, { desc = "切换终端 2（跟随 neo-tree 根）" })

        vim.keymap.set("n", "<leader>tf", function()
          toggle_with_cwd(float_term)
        end, { desc = "浮动终端（跟随 neo-tree 根）" })
    end,
}
