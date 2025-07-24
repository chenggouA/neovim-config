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

return M
