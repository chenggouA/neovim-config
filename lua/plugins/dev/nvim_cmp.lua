return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip",
			-- 禁用原生编译，避免 macOS 编译问题
			build = nil,
			dependencies = { "rafamadriz/friendly-snippets" },
			opts = { history = true, updateevents = "TextChanged,TextChangedI" },
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = require("core.keymaps.cmp").mapping(cmp, luasnip),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					local menus = {
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buf]",
						path = "[Path]",
					}
					vim_item.menu = menus[entry.source.name]
					return vim_item
				end,
			},
		})
	end,
}
