local M = {}

---Get the absolute path of current virtual environment.
---@return string|nil
function M.get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv and venv ~= "" then
    return venv
  end
  return nil
end

---Return the name (last segment) of the virtual environment.
---@return string|nil
function M.venv_name()
  local venv = M.get_venv()
  if venv then
    return vim.fn.fnamemodify(venv, ":t")
  end
end

---Return the python executable inside the active virtual environment.
---@return string|nil
function M.python_from_venv()
  local venv = M.get_venv()
  if not venv then return nil end
  local sep = package.config:sub(1,1) == "\\" and "\\" or "/"
  return venv .. sep .. (sep == "\\" and "Scripts\\python.exe" or "bin/python")
end

---Return the site-packages path of the active virtual environment.
---@return string|nil
function M.site_packages()
  local venv = M.get_venv()
  if not venv then return nil end
  local sep = package.config:sub(1,1) == "\\" and "\\" or "/"
  if sep == "\\" then
    return venv .. "\\Lib\\site-packages"
  else
    local pyver = vim.version().major .. "." .. vim.version().minor
    return string.format("%s/lib/python%s/site-packages", venv, pyver)
  end
end

---Get the path to pyproject.toml in the project root.
---@param root_dir string The project root directory.
---@return string
function M.project_config(root_dir)
  -- 想让 Ruff 读 pyproject.toml 就放这；若用 .ruff.toml 改下文件名即可
  return vim.fs.joinpath(root_dir, "pyproject.toml")
end

return M
