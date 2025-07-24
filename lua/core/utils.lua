local M = {}

-- 合并多个列表为一个列表
function M.merge_tables(...)
  local result = {}
  -- 遍历传入的每个表
  for _, tbl in ipairs({ ... }) do
    -- 将表中的每个元素插入结果
    for _, item in ipairs(tbl) do
      table.insert(result, item)
    end
  end
  return result
end


function M.get_preferred_shell()
  if vim.fn.has("win32") == 1 then
    local pwsh = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
    if vim.fn.executable(pwsh) == 1 then
      return pwsh
    else
      return "powershell"
    end
  else
    if vim.fn.executable("zsh") == 1 then
      return "zsh"
    else
      return "bash"
    end
  end
end

return M
