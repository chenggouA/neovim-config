-- Temporary key test utility for debugging Alt key issues in Neovide
local M = {}

-- Test function that shows what key was pressed
M.test_key = function()
    vim.notify("Key test mode activated. Press any key (ESC to exit)...", vim.log.levels.INFO)

    -- Get a single character input
    local ok, char = pcall(vim.fn.getchar)
    if not ok then
        vim.notify("Test cancelled", vim.log.levels.WARN)
        return
    end

    -- Convert to string if it's a number
    local key_str = type(char) == "number" and vim.fn.nr2char(char) or tostring(char)
    local key_code = type(char) == "number" and char or vim.fn.char2nr(char)

    -- Display the results
    local message = string.format(
        "Key Info:\n  Character: %s\n  Decimal: %d\n  Hex: 0x%X\n  Octal: %o",
        key_str,
        key_code,
        key_code,
        key_code
    )

    vim.notify(message, vim.log.levels.INFO)

    -- Also print to command line for easy copying
    print(message)
end

-- Interactive test mode - keeps testing until ESC
M.interactive_test = function()
    vim.notify("Interactive key test mode (ESC to exit)", vim.log.levels.INFO)

    while true do
        local ok, char = pcall(vim.fn.getchar)
        if not ok then
            break
        end

        -- Exit on ESC (27)
        if char == 27 then
            vim.notify("Key test mode exited", vim.log.levels.INFO)
            break
        end

        local key_str = type(char) == "number" and vim.fn.nr2char(char) or tostring(char)
        local key_code = type(char) == "number" and char or vim.fn.char2nr(char)

        print(string.format("Key: %s | Dec: %d | Hex: 0x%X", key_str, key_code, key_code))
    end
end

-- Setup test keymaps for Alt keys
M.setup_test_keymaps = function()
    -- Test Alt key mappings
    local test_keys = { "h", "j", "k", "l", "t", "n" }

    for _, key in ipairs(test_keys) do
        vim.keymap.set("n", "<M-" .. key .. ">", function()
            vim.notify(
                string.format("✓ Alt+%s is working! (received <M-%s>)", key, key),
                vim.log.levels.INFO
            )
        end, { desc = "Test Alt+" .. key })
    end

    vim.notify("Alt key test mappings installed. Try pressing Alt+h/j/k/l/t/n", vim.log.levels.INFO)
end

-- Cleanup test keymaps
M.cleanup_test_keymaps = function()
    local test_keys = { "h", "j", "k", "l", "t", "n" }

    for _, key in ipairs(test_keys) do
        vim.keymap.del("n", "<M-" .. key .. ">")
    end

    vim.notify("Alt key test mappings removed", vim.log.levels.INFO)
end

-- Setup commands
M.setup = function()
    vim.api.nvim_create_user_command("KeyTest", M.test_key, {
        desc = "Test a single key press and show its code"
    })

    vim.api.nvim_create_user_command("KeyTestInteractive", M.interactive_test, {
        desc = "Interactive key testing mode (ESC to exit)"
    })

    vim.api.nvim_create_user_command("KeyTestAlt", M.setup_test_keymaps, {
        desc = "Install Alt key test mappings (Alt+h/j/k/l/t/n)"
    })

    vim.api.nvim_create_user_command("KeyTestAltClean", M.cleanup_test_keymaps, {
        desc = "Remove Alt key test mappings"
    })

    vim.notify("Key test commands loaded: :KeyTest, :KeyTestInteractive, :KeyTestAlt", vim.log.levels.INFO)
end

return M
