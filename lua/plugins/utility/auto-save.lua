-- lua/plugins/auto-save.lua  （按需放到你的 plugins 目录）

return {
	-- 1) 插件来源
	"pocco81/auto-save.nvim",
	-- 2) 让 lazy.nvim 仅在离开插入模式或 I 内文本改动时才加载插件
	event = { "InsertLeave", "TextChangedI" },

	-- 3) 真正的配置
	config = function()
		require("auto-save").setup({
			--------------------------------------------------------------------
			-- ★ 覆写默认触发点：只监听 InsertLeave + TextChangedI
			--------------------------------------------------------------------
			trigger_events = { "InsertLeave", "TextChangedI" },

			-- ★ 防抖：与官方一致；可加长到 500ms 看个人习惯
			debounce_delay = 135,

			-- ★ 是否一次写所有 buffer
			write_all_buffers = false,

			--------------------------------------------------------------------
			-- 保存前的过滤逻辑（沿用你之前的 condition）
			--------------------------------------------------------------------
			condition = function(buf)
				local fn = vim.fn

				-- ① 仅当前窗口 buffer
				if buf ~= vim.api.nvim_get_current_buf() then
					return false
				end

				-- ② buffer 可编辑
				if fn.getbufvar(buf, "&modifiable") == 0 then
					return false
				end

				-- ③ 忽略 Git commit 信息
				local filename = fn.expand("%:p")
				if filename:match("COMMIT_EDITMSG") then
					return false
				end

				-- ④ 只在插入模式下保存，防止 Normal 模式的 u/redo
				if fn.mode() ~= "i" then
					return false
				end

				return true
			end,

			--------------------------------------------------------------------
			-- 纯装饰：保存后在 Cmdline 闪一句话，可按需关闭
			--------------------------------------------------------------------
			execution_message = {
				message = function()
					return ("󰄳 AutoSave " .. os.date("%H:%M:%S"))
				end,
				dim = 0.18,
				cleaning_interval = 1500,
			},

			-- 是否生成 :ASToggle/:ASDisable/:ASEnable 命令
			on_off_commands = true,
		})
	end,
}
