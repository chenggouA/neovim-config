# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration is designed to be lightweight, extensible, and suitable for daily coding with strong Python development support.

## Architecture

### Entry Point & Loading Order

1. **init.lua**: Entry point that:
   - Loads core modules (`core.options`, `core.keymaps`)
   - Bootstraps lazy.nvim if not present
   - Loads all plugins via `require("lazy").setup("plugins")`

2. **Core modules** (`lua/core/`):
   - `options.lua`: Editor settings (line numbers, indentation, folding, etc.)
   - `keymaps/init.lua`: Loads general keymaps module
   - `keymaps/general.lua`: Core keybindings setup (leader key, buffer management, clipboard integration)
   - `keymaps/*.lua`: Plugin-specific keymaps organized by plugin name
   - `utils.lua`: Shared utilities (table merging, shell detection)
   - `python.lua`: Python environment management (venv detection, activation, LSP integration)

3. **Plugin system** (`lua/plugins/`):
   - `init.lua`: Aggregates all plugin specs via `merge_tables()` from subdirectories
   - Subdirectories organize plugins by category:
     - `appearance/`: UI plugins (themes, statusline, transparency)
     - `dev/`: Development tools (LSP, completion, formatters, treesitter)
     - `navigation/`: File tree, telescope, window management
     - `utility/`: Terminal, auto-save
     - `git/`: Git integration (fugitive, gitsigns, diffview)

### Python Environment Management

The configuration includes sophisticated Python virtual environment handling via `core.python`:

- **Auto-detection**: Finds `.venv` directories in project roots
- **venv activation**: `<leader>va` activates project venv and restarts Pyright
- **LSP integration**: Pyright is configured via `before_init` and `on_new_config` hooks to:
  - Set `python.defaultInterpreterPath` to venv Python
  - Configure `python.venvPath` and `python.venv`
  - Add `site-packages` to `python.analysis.extraPaths`
  - Export `VIRTUAL_ENV` and update `PATH` in Pyright's process environment
- **Terminal integration**: `activation_command()` generates shell-specific activation commands for toggleterm

### Keymap Organization

Keymaps are split across multiple files in `lua/core/keymaps/`:
- Each plugin has its own keymap module (e.g., `lsp.lua`, `telescope.lua`, `neo_tree.lua`)
- Plugin keymap modules export either:
  - A `setup()` function called during plugin initialization
  - A `keys` table used directly by lazy.nvim's `keys` spec
  - An `on_attach` function for LSP-specific keybindings

### LSP Configuration

LSP is configured in `lua/plugins/dev/nvim_lspconfig.lua`:
- Mason auto-installs language servers (currently only `pyright`)
- Shared `capabilities` from nvim-cmp
- Shared `on_attach` function loads LSP keymaps from `core.keymaps.lsp`
- Pyright gets special handling for Python venvs (see Python section above)

### Formatting

Formatting is handled by conform.nvim (`lua/plugins/dev/conform.lua`):
- **Lua**: stylua
- **JSON**: jq
- **Markdown**: prettier
- **Python**: ruff (fix → format pipeline)
- Triggered manually via `<leader>cf` (defined in `core.keymaps.conform`)

## Key Commands

### Plugin Management
```vim
:Lazy sync          " Update plugins
:Lazy update        " Update plugins (alias)
```

### LSP
```vim
:LspRestart         " Restart LSP servers
```

### Python Development
- Press `<leader>va` to activate project `.venv` and restart Pyright
- The configuration automatically finds `.venv` in project root (detected via `.git`, `pyproject.toml`, etc.)
- Pyright will use the venv's Python interpreter and site-packages

### Formatting
- Press `<leader>cf` to format current buffer using conform.nvim
- Formatters must be installed externally: `stylua`, `jq`, `prettier`, `ruff`

## Important Design Patterns

1. **Keymap definition**: Use the local `map()` function pattern for consistency:
   ```lua
   local function map(mode, lhs, rhs, desc)
       vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
   end
   ```

2. **Plugin specs**: Each plugin module returns a lazy.nvim spec table with structure:
   ```lua
   return {
       "plugin/name",
       dependencies = { ... },
       opts = { ... },
       config = function() ... end,
       keys = { ... }
   }
   ```

3. **Table merging**: Plugin categories use `merge_tables()` from `core.utils` to combine multiple spec arrays into one

4. **Python venv handling**: Always use `core.python` module functions instead of hardcoding paths:
   - `get_venv()`: Get active venv path
   - `python_from_venv()`: Get Python executable path
   - `site_packages_list()`: Get site-packages directories
   - `activate_project_venv()`: Activate project .venv

5. **Shell detection**: Use `core.utils.get_preferred_shell()` for cross-platform shell commands (Windows PowerShell vs Unix bash/zsh)

## Configuration Values

- **Leader key**: Space (`" "`)
- **Indentation**: 4 spaces (no tabs)
- **Fold method**: Tree-sitter expressions (`foldmethod=expr`, `foldexpr=v:lua.vim.treesitter.foldexpr()`)
- **Clipboard**: Not synced with system by default (use `<leader>y` / `<leader>p` for system clipboard)
- **Font** (Neovide): JetBrainsMono Nerd Font, size 14
- **Python type checking**: Pyright with `typeCheckingMode = "basic"`

## External Dependencies

Required for full functionality:
- **Neovim** ≥ 0.9
- **C compiler** (for tree-sitter)
- **Nerd Font** (recommended: JetBrainsMono)
- **ripgrep** (for telescope live grep)
- **Formatters** (optional): stylua, jq, prettier, ruff

## Testing & Development

This is a personal configuration without automated tests. When modifying:
1. Test plugin loading: `:Lazy check` and `:Lazy load <plugin>`
2. Test LSP: Open Python file and verify `:LspInfo` shows Pyright attached
3. Test formatting: Open file and press `<leader>cf`
4. Test Python venv: Navigate to project with `.venv` and press `<leader>va`
