return {
	"mason-org/mason.nvim",
	-- 不使用 cmd 延迟加载，作为 lspconfig 的依赖自动加载
	config = function()
		-- 先初始化 mason
		require("mason").setup()
	end,
	dependencies = {
		-- Mason-LspConfig: 自动安装 LSP 服务器
		{
			"mason-org/mason-lspconfig.nvim",
			config = function()
				-- mason 已经在父插件中初始化，现在可以安全地设置 mason-lspconfig
				require("mason-lspconfig").setup({
					-- 自动安装的 LSP 服务器
					-- 注意:
					--   - clangd 在 ARM Mac 上需要手动安装（不在此列表）
					--   - 格式化工具（prettier, stylua, jq）需通过 :Mason 手动安装
					ensure_installed = { "pyright", "jsonls", "marksman" },
					automatic_enable = false, -- 不自动启动（由 lspconfig 手动控制）
					automatic_installation = true, -- 自动安装缺失的 LSP
				})
			end,
		},
	},
}
