return {
	"mason-org/mason.nvim",
	-- 不使用 cmd 延迟加载，作为 lspconfig 的依赖自动加载
	config = function()
		-- 先初始化 mason
		require("mason").setup()

		-- LSP 服务器管理
		require("mason-lspconfig").setup({
			ensure_installed = {
				"pyright",   -- Python LSP
				"jsonls",    -- JSON LSP
				"marksman",  -- Markdown LSP
				"bufls",     -- Protocol Buffers LSP
				"clangd",    -- C/C++ LSP
			},
			automatic_enable = false,     -- 不自动启动（由 lspconfig 手动控制）
			automatic_installation = true, -- 自动安装缺失的 LSP
		})

		-- Formatters & Linters 管理
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"stylua",   -- Lua formatter
				"prettier", -- Markdown/JSON formatter
				"ruff",     -- Python formatter/linter
				"buf",      -- Protocol Buffers formatter
                "jq",       -- JSON formatter
			},
			auto_update = true,       -- 自动更新工具
			run_on_start = true,      -- 启动时检查并安装
			start_delay = 3000,       -- 延迟 3 秒启动（避免干扰启动速度）
		})
	end,
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}
