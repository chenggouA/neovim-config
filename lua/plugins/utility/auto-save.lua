return {
	"pocco81/auto-save.nvim",
	event = { "InsertLeave", "TextChangedI" },

	config = function()
		require("auto-save").setup({
			trigger_events = { "InsertLeave", "TextChangedI" },
			debounce_delay = 135,
			write_all_buffers = false,

			condition = function(buf)
				local fn = vim.fn

				-- 仅当前 buffer
				if buf ~= vim.api.nvim_get_current_buf() then
					return false
				end

				-- buffer 可编辑
				if fn.getbufvar(buf, "&modifiable") == 0 then
					return false
				end

				-- 忽略 git commit 窗口
				local filename = fn.expand("%:p")
				if filename:match("COMMIT_EDITMSG") then
					return false
				end

				return true
			end,

			execution_message = {
				message = function()
					return ("󰄳 AutoSave " .. os.date("%H:%M:%S"))
				end,
				dim = 0.18,
				cleaning_interval = 1500,
			},

			on_off_commands = true,
		})
	end,
}
