local M = {}

function M.setup(term1, term2, float_term)
	vim.keymap.set("n", "<leader>t1", function()
		term1:toggle()
	end, { desc = "切换终端 1" })
	vim.keymap.set("n", "<leader>t2", function()
		term2:toggle()
	end, { desc = "切换终端 2" })
	vim.keymap.set("n", "<leader>tf", function()
		float_term:toggle()
	end, { desc = "浮动终端" })

	-- 彻底关闭（杀死）当前聚焦的 ToggleTerm 终端
	local function kill_focused_toggleterm()
		local termmod = require("toggleterm.terminal")
		local id = termmod.get_focused_id() or select(1, termmod.identify())
		if id then
			local term = termmod.get(id, true)
			if term and term.shutdown then
				term:shutdown()
				return
			end
		end
		-- 回退：不是 toggleterm 或未识别，执行普通 close
		pcall(vim.cmd, "close")
	end

	-- 彻底关闭全部 ToggleTerm 终端
	local function kill_all_toggleterms()
		local termmod = require("toggleterm.terminal")
		for _, term in ipairs(termmod.get_all(true)) do
			if term and term.shutdown then term:shutdown() end
		end
	end

	-- 只在 Normal mode 下使用 leader 键，避免 Terminal mode 下空格延迟
	vim.keymap.set("n", "<leader>tq", kill_focused_toggleterm, { desc = "关闭当前 ToggleTerm (kill)" })
	vim.keymap.set("n", "<leader>tQ", kill_all_toggleterms, { desc = "关闭全部 ToggleTerm (kill all)" })

	-- Terminal mode：使用 Esc 退出到 Normal mode，或用 Ctrl 快捷键
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "退出终端模式" })
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "切换到左侧窗口" })
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "切换到右侧窗口" })
end

return M
