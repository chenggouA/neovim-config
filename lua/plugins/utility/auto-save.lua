return {
	"pocco81/auto-save.nvim",
	event = { "InsertLeave", "TextChanged" }, -- 自动保存触发点
	condition = function(buf)
		local fn = vim.fn

		-- 当前 buffer 是否是当前窗口中的 buffer
		if buf ~= vim.api.nvim_get_current_buf() then
			return false
		end

		-- 是否可编辑
		if fn.getbufvar(buf, "&modifiable") == 0 then
			return false
		end

		-- 忽略 Git commit 文件等
		local filename = fn.expand("%:p")
		if filename:match("COMMIT_EDITMSG") then
			return false
		end

		return true
	end,
}
