
local M = {}

function M.merge_tables(...)
  local result = {}
  for _, tbl in ipairs({...}) do
    for _, item in ipairs(tbl) do
      table.insert(result, item)
    end
  end
  return result
end

return M
