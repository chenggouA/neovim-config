return {
	"chenggouA/uv.nvim",
	event = "VeryLazy",
	opts = {
		auto_activate_venv = true,
		picker_integration = true,
		on_activate = function(venv_path)
			for _, client in ipairs(vim.lsp.get_active_clients()) do
				if client.name == "pyright" then
					client.stop()
				end
			end
			vim.defer_fn(function()
				vim.cmd("edit")
			end, 100)
		end,
	},
	keys = require("core.keymaps.uv").keys,
}
