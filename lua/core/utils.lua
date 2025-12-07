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
		-- Windows: 优先使用 pwsh (PowerShell 7+)
		if vim.fn.executable("pwsh") == 1 then
			return "pwsh"
		else
			return "powershell"
		end
	else
		-- Unix-like 系统：优先使用用户的默认 shell ($SHELL)
		local user_shell = vim.env.SHELL
		if user_shell and user_shell ~= "" then
			-- 提取 shell 名称（去掉路径）
			local shell_name = vim.fn.fnamemodify(user_shell, ":t")
			-- 验证该 shell 是否可执行
			if vim.fn.executable(shell_name) == 1 or vim.fn.executable(user_shell) == 1 then
				return user_shell
			end
		end

		-- 回退：依次尝试常见 shell
		if vim.fn.executable("zsh") == 1 then
			return "zsh"
		elseif vim.fn.executable("bash") == 1 then
			return "bash"
		else
			return "sh"
		end
	end
end

return M
