return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = require("core.keymaps.telescope").keys,
	cmd = "Telescope",
	opts = function()
		return {
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					height = 0.9,
					width = 0.9,
					prompt_position = "top",
					mirror = true,
				},
				sorting_strategy = "ascending",
				prompt_prefix = " 🔍 ",
				selection_caret = "❯ ",
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				mappings = {
					i = {
						["<ESC>"] = require("telescope.actions").close,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
			pickers = {
				current_buffer_fuzzy_find = {
					previewer = false,
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						prompt_position = "top",
					},
				},
			},
		}
	end,
}
