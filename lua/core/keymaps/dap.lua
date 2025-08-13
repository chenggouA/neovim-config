local M = {}

function M.setup()
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
  end

  -- which-key: 注册 <leader>d 分组（即时尝试 + VeryLazy 事件回退）
  local function register_which_key_group()
    local ok, wk = pcall(require, "which-key")
    if not ok then return false end
    if type(wk.add) == "function" then
      wk.add({ { "<leader>d", group = "调试 (DAP)" } })
    elseif type(wk.register) == "function" then
      wk.register({ d = { name = "调试 (DAP)" } }, { prefix = "<leader>" })
    end
    return true
  end
  if not register_which_key_group() then
    local aug = vim.api.nvim_create_augroup("WhichKeyRegisterDAP", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      group = aug,
      callback = function()
        register_which_key_group()
      end,
      desc = "Register <leader>d group for which-key (DAP) on VeryLazy",
    })
    vim.api.nvim_create_autocmd("VimEnter", {
      group = aug,
      callback = function()
        if not register_which_key_group() then
          vim.defer_fn(register_which_key_group, 200)
        end
      end,
      desc = "Register <leader>d group for which-key (DAP) on VimEnter",
    })
  end

  -- F keys
  map("n", "<F5>", function() require("dap").continue() end, "继续/启动调试")
  map("n", "<F10>", function() require("dap").step_over() end, "单步跳过")
  map("n", "<F11>", function() require("dap").step_into() end, "单步进入")
  map("n", "<S-F11>", function() require("dap").step_out() end, "单步跳出")
  -- Breakpoint F key (VSCode-like)
  map("n", "<F9>", function() require("persistent-breakpoints.api").toggle_breakpoint() end, "切换断点(持久化)")

  -- Leader scheme
  map("n", "<leader>dc", function() require("dap").continue() end, "继续/启动调试")
  map("n", "<leader>dn", function() require("dap").step_over() end, "单步跳过(next)")
  map("n", "<leader>di", function() require("dap").step_into() end, "单步进入")
  map("n", "<leader>do", function() require("dap").step_out() end, "单步跳出")
  map("n", "<leader>du", function() require("dapui").toggle() end, "切换 DAP UI")
  map("n", "<leader>dp", function() require("dap").repl.open() end, "打开 DAP REPL")

  map("n", "<leader>db", function() require("persistent-breakpoints.api").toggle_breakpoint() end, "切换断点(持久化)")
  map("n", "<leader>dB", function()
    require("persistent-breakpoints.api").set_conditional_breakpoint(vim.fn.input("条件: "))
  end, "条件断点(持久化)")
  map("n", "<leader>dl", function()
    require("persistent-breakpoints.api").set_log_point(vim.fn.input("日志: "))
  end, "日志点(持久化)")

  map("n", "<leader>dr", function() require("dap").restart() end, "重启调试会话")
  map("n", "<leader>dq", function() require("dap").terminate() end, "退出调试")
  map("n", "<leader>de", function() require("dapui").eval() end, "评估变量/表达式")

  -- Reload VSCode launch.json
  map("n", "<leader>dL", function()
    -- 确保按下时加载 nvim-dap，从而注册用户命令
    pcall(require, "dap")
    vim.cmd("DapReloadLaunchJson")
  end, "Reload VSCode launch.json")
end

return M
