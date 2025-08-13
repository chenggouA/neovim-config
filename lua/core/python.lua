---@class CorePython
local M = {}
local utils = require("core.utils")

---Return the configured Python host interpreter, if any.
---@return string|nil
local function get_python_host_prog()
    local host = vim.g.python3_host_prog
    if type(host) == "string" and host ~= "" then
        return host
    end
    return nil
end

---Get the absolute path of current virtual environment.
---@return string|nil
function M.get_venv()
    local venv = vim.env.VIRTUAL_ENV
    if venv and venv ~= "" then
        return venv
    end
    -- Derive from python3 host prog if available (works with whichpy.nvim)
    local host = get_python_host_prog()
    if host then
        local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
        -- Typically: <venv>/bin/python or <venv>\\Scripts\\python.exe
        local parent = vim.fn.fnamemodify(host, ":h")
        local venv_from_host = vim.fn.fnamemodify(parent, ":h")
        local pyvenv_cfg = venv_from_host .. sep .. "pyvenv.cfg"
        if vim.uv.fs_stat(pyvenv_cfg) then
            return venv_from_host
        end
    end
    return nil
end

---Return the name (last segment) of the virtual environment.
---@return string|nil
function M.venv_name()
    local venv = M.get_venv()
    if venv then
        return vim.fn.fnamemodify(venv, ":t")
    end
end

---Return the python executable inside the active virtual environment.
---@return string|nil
function M.python_from_venv()
    local venv = M.get_venv()
    if not venv then
        return nil
    end
    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
    return venv .. sep .. (sep == "\\" and "Scripts\\python.exe" or "bin/python")
end

---Return the site-packages path of the active virtual environment.
---@return string|nil
function M.site_packages()
    local venv = M.get_venv()
    if not venv then
        return nil
    end
    local py = M.python_from_venv()
    if not py then
        return nil
    end
    -- Ask Python directly for its purelib path
    local ok, out = pcall(vim.fn.systemlist, { py, "-c", "import sysconfig; print(sysconfig.get_paths().get('purelib',''))" })
    local sp = (ok and type(out) == "table" and out[1]) and vim.trim(out[1]) or nil
    if sp and sp ~= "" then
        return sp
    end
    -- Fallbacks
    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
    if sep == "\\" then
        return venv .. "\\Lib\\site-packages"
    end
    return nil
end

---Return all relevant site-packages-like directories for the active venv.
---@return string[]|nil
function M.site_packages_list()
    local venv = M.get_venv()
    if not venv then
        return nil
    end
    local py = M.python_from_venv()
    if not py then
        return nil
    end
    -- Query both purelib and platlib to cover compiled extensions
    local ok, out = pcall(vim.fn.systemlist, { py, "-c", "import sysconfig, json; p=sysconfig.get_paths(); print(json.dumps([p.get('purelib',''), p.get('platlib','')]))" })
    local paths = {}
    if ok and type(out) == "table" and out[1] then
        local ok_decode, arr = pcall(vim.json.decode, out[1])
        if ok_decode and type(arr) == "table" then
            for _, p in ipairs(arr) do
                if type(p) == "string" and p ~= "" then
                    paths[#paths + 1] = vim.trim(p)
                end
            end
        end
    end
    -- Fallback for Windows if empty
    if #paths == 0 then
        local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
        if sep == "\\" then
            paths = { venv .. "\\Lib\\site-packages" }
        end
    end
    -- Deduplicate
    local seen, uniq = {}, {}
    for _, p in ipairs(paths) do
        if not seen[p] then
            seen[p] = true
            table.insert(uniq, p)
        end
    end
    return (#uniq > 0) and uniq or nil
end

---Find project root based on common markers.
---@param file? string Absolute path of a file/buffer to anchor from
---@return string root_dir
local function find_project_root(file)
    local anchor = file
    if not anchor or anchor == "" then
        local ok, cwd = pcall(function()
            return (vim.uv or vim.loop).cwd()
        end)
        anchor = (ok and cwd) or vim.loop.cwd() or vim.fn.getcwd()
    end
    local markers = { ".git", "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".venv" }
    local root = vim.fs.root(anchor, markers)
    return root or vim.fs.dirname(anchor)
end

---Find a `.venv` directory for the current project.
---@param file? string Optional file to anchor root detection
---@return string|nil venv_dir
function M.find_project_venv(file)
    local root = find_project_root(file or vim.api.nvim_buf_get_name(0))
    if not root or root == "" then
        return nil
    end
    local venv = vim.fs.joinpath(root, ".venv")
    local uv = vim.uv or vim.loop
    if uv.fs_stat(venv) then
        -- sanity check: contains bin/Scripts
        local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
        local pyvenv_cfg = venv .. sep .. "pyvenv.cfg"
        if uv.fs_stat(pyvenv_cfg) then
            return venv
        end
        -- some uv venvs don't include pyvenv.cfg at root; fall back to directory check
        local bin_dir = venv .. sep .. (sep == "\\" and "Scripts" or "bin")
        if uv.fs_stat(bin_dir) then
            return venv
        end
    end
    return nil
end

---Activate the project's `.venv` for the current Neovim session and restart Pyright.
---@return string|nil venv_dir The activated venv path, or nil if activation failed
function M.activate_project_venv()
    local venv = M.find_project_venv()
    if not venv then
        vim.notify("No .venv found in project", vim.log.levels.WARN)
        return nil
    end
    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
    local path_sep = (sep == "\\") and ";" or ":"
    local bin_dir = venv .. sep .. (sep == "\\" and "Scripts" or "bin")

    -- Export environment for the running Neovim process
    vim.env.VIRTUAL_ENV = venv
    if type(vim.env.PATH) == "string" then
        -- Prepend bin_dir to PATH if not already present at the front
        local current_path = vim.env.PATH
        local prefix = bin_dir .. path_sep
        if not current_path:find("^" .. vim.pesc(prefix)) and not current_path:find("^" .. vim.pesc(bin_dir)) then
            vim.env.PATH = prefix .. current_path
        end
    else
        vim.env.PATH = bin_dir
    end

    -- Configure python host for provider-based plugins
    local py_exe = bin_dir .. (sep == "\\" and "\\python.exe" or "/python")
    vim.g.python3_host_prog = py_exe

    -- Apply pyright settings live if client is running; otherwise restart later
    local function apply_pyright_live()
        local clients = vim.lsp.get_active_clients({ name = "pyright" })
        if #clients == 0 then
            return false
        end
        local sps = M.site_packages_list() or (M.site_packages() and { M.site_packages() })
        for _, client in ipairs(clients) do
            local settings = client.config.settings or {}
            settings.python = settings.python or {}
            settings.python.defaultInterpreterPath = py_exe
            settings.python.venvPath = vim.fn.fnamemodify(venv, ":h")
            settings.python.venv = vim.fn.fnamemodify(venv, ":t")
            if sps and #sps > 0 then
                settings.python.analysis = settings.python.analysis or {}
                settings.python.analysis.extraPaths = sps
            end
            client.config.settings = settings
            pcall(client.notify, "workspace/didChangeConfiguration", { settings = settings })
        end
        return true
    end

    if not apply_pyright_live() then
        pcall(M.restart_pyright)
    end
    local name = vim.fn.fnamemodify(venv, ":t")
    vim.notify("Activated .venv: " .. name, vim.log.levels.INFO)
    return venv
end

---Get the path to pyproject.toml in the project root.
---@param root_dir string The project root directory.
---@return string
function M.project_config(root_dir)
    return vim.fs.joinpath(root_dir, "pyproject.toml")
end

---Restart Pyright LSP to pick up new interpreter/venv.
function M.restart_pyright()
    -- Prefer built-in command if available
    if vim.fn.exists(":LspRestart") == 2 then
        vim.cmd("LspRestart")
        return
    end
    -- Fallback: stop clients and re-open current buffer
    local clients = vim.lsp.get_active_clients({ name = "pyright" })
    for _, client in ipairs(clients) do
        client.stop(true)
    end
    vim.defer_fn(function()
        local bufnr = vim.api.nvim_get_current_buf()
        if vim.bo[bufnr].filetype == "python" then
            vim.cmd("edit")
        end
    end, 100)
end

---Build a shell command to activate the current venv in an interactive terminal.
---Returns nil if no venv is active.
---@return string|nil
function M.activation_command()
    local venv = M.get_venv()
    if not venv or venv == "" then
        return nil
    end

    local sep = package.config:sub(1, 1) == "\\" and "\\" or "/"
    local shell = utils.get_preferred_shell()

    -- Linux/macOS shells
    if shell == "zsh" or shell == "bash" then
        local activate = venv .. sep .. (sep == "\\" and "Scripts\\activate" or "bin/activate")
        -- Only source when $VIRTUAL_ENV is set (it will be set by Neovim) to avoid accidental project picking
        return string.format("[ -n \"$VIRTUAL_ENV\" ] && source \"%s\"", activate)
    end

    -- PowerShell (Windows)
    if shell == "pwsh" or shell == "powershell" then
        local activate_ps1 = venv .. "\\" .. "Scripts\\Activate.ps1"
        return string.format("if ($env:VIRTUAL_ENV) { & \"%s\" }", activate_ps1)
    end

    -- Fallback: POSIX compatible
    local activate = venv .. sep .. (sep == "\\" and "Scripts\\activate" or "bin/activate")
    return string.format("[ -n \"$VIRTUAL_ENV\" ] && . \"%s\"", activate)
end

return M
