local M = {}

-- 找项目根的辅助函数（模块私有）
local function project_root_from(buf)
  -- 检查是否是 terminal buffer
  local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
  if buftype == "terminal" then
    -- Terminal buffer：使用 vim 的当前工作目录
    return vim.loop.cwd()
  end

  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return vim.loop.cwd()
  end
  local root = vim.fs.root(file, {
    ".git",
    ".hg",
    "pyproject.toml",
    "package.json",
    "go.mod",
    "Cargo.toml",
    "Makefile",
  })
  return root or vim.fn.fnamemodify(file, ":p:h")
end

-- 按项目根打开 Neo-tree 并 reveal 当前文件
function M.open_neotree_project_root()
  local root = project_root_from(0)
  vim.cmd("Neotree reveal dir=" .. vim.fn.fnameescape(root))
end

-- 在项目根切换 Neo-tree（打开则关闭，关闭则打开并定位当前文件）
function M.toggle_neotree_project_root()
  local root = project_root_from(0)
  vim.cmd("Neotree toggle reveal dir=" .. vim.fn.fnameescape(root))
end

return M
