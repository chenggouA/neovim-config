
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",  -- dap-ui 依赖
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 使用工具函数获取当前已激活的 Python 解释器（兼容 uv/.venv）
    local python_utils = require("core.python")
    local py = python_utils.python_from_venv() or "python"
    require("dap-python").setup(py)

    -- 符号与高亮：断点小红点、停止箭头（风格贴近 VSCode）
    local set_hl = vim.api.nvim_set_hl
    local sign_define = vim.fn.sign_define
    -- 颜色取自 VSCode 调试：红色断点(#E51400)，黄色当前行与停止箭头
    set_hl(0, "DapBreakpoint", { fg = "#E51400" })
    set_hl(0, "DapStopped", { fg = "#FFC517" })
    set_hl(0, "DapStoppedLine", { bg = "#3a3a00" })
    -- 使用 Nerd Font 大圆点字符
    sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", numhl = "" })
    sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", numhl = "" })
    sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", numhl = "" })
    sign_define("DapLogPoint", { text = "◆", texthl = "DapBreakpoint", numhl = "" })
    sign_define("DapStopped", { text = "▶", texthl = "DapStopped", numhl = "", linehl = "DapStoppedLine" })

    -- 持久化断点（自动在 BufReadPost 加载）
    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })

    -- 读取 VSCode 的 .vscode/launch.json（需要与已安装的 adapter 名称对应）
    local vscode = require("dap.ext.vscode")
    local launch_mappings = {
      -- VSCode 中 language -> nvim-dap adapter 名称
      python = { "python" },
      -- 如需 JS/TS、Go、C/C++ 等，在安装相应 adapter 后按需添加：
      -- javascript = { "pwa-node", "node2" },
      -- typescript = { "pwa-node", "node2" },
      -- go = { "go" },
      -- cpp = { "codelldb", "lldb" },
      -- c = { "codelldb", "lldb" },
      -- rust = { "codelldb" },
    }
    -- 启动时加载当前工作目录的 .vscode/launch.json（也会尝试项目根）
    vscode.load_launchjs(nil, launch_mappings)
    -- 目录变化时自动重载，便于在不同项目间切换
    vim.api.nvim_create_autocmd({ "DirChanged" }, {
      group = vim.api.nvim_create_augroup("DapLoadLaunchJsonOnDirChanged", { clear = true }),
      callback = function()
        vscode.load_launchjs(nil, launch_mappings)
      end,
      desc = "Auto reload .vscode/launch.json on directory change",
    })
    -- 手动命令以便随时重载 launch.json
    vim.api.nvim_create_user_command("DapReloadLaunchJson", function()
      vscode.load_launchjs(nil, launch_mappings)
      vim.notify("nvim-dap: launch.json reloaded", vim.log.levels.INFO)
    end, {})

    dapui.setup({
      mappings = {
        -- 在 DAP UI 面板内展开/折叠（同一个键位用于切换）
        expand = { "<CR>", "<2-LeftMouse>", "l", "h", "<Right>", "<Left>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
    })

    -- 调试开始/结束时自动打开/关闭 UI
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end

    -- 全局按键已迁移到 core/keymaps/dap.lua
  end
}
