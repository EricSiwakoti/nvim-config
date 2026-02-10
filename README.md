<p align="center">
<svg width="400" height="115" viewBox="0 0 742 214" xmlns="http://www.w3.org/2000/svg">
<text x="371" y="140" font-family="monospace" font-size="120" fill="#00D2B4" text-anchor="middle" font-weight="bold">Neovim</text>
</svg>
</p>

<h1 align="center">Eric's Personal Config</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.10%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
  <img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua"/>
  <img src="https://img.shields.io/badge/Theme-Carbonfox-1e1e2e?style=for-the-badge" alt="Theme"/>
  <img src="https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-blue?style=for-the-badge" alt="lazy.nvim"/>
</p>

<p align="center">
  A modular, performance-tuned Neovim configuration built on <strong>lazy.nvim</strong> with transparent Carbonfox theming, full LSP/DAP support, and AI-assisted development via Copilot and CodeCompanion.
</p>

---

## ✨ Features

- **Lazy-loaded plugins** — sub-100ms startup via lazy.nvim with aggressive deferred loading
- **Full LSP ecosystem** — Mason-managed servers, Lspsaga UI, diagnostics, and formatting via conform.nvim
- **AI integration** — GitHub Copilot completions + CodeCompanion chat (Copilot/Gemini adapters)
- **DAP debugging** — Go (Delve), JavaScript/TypeScript (node-debug2) with virtual text + UI
- **Modern navigation** — Flash.nvim motions, Harpoon2 file marks, Snacks picker (telescope-style)
- **Git workflow** — Fugitive, Gitsigns hunk management, LazyGit TUI, vim-illuminate
- **Transparent Carbonfox theme** with custom lualine statusline
- **Treesitter-powered** syntax highlighting, folding (nvim-ufo), and incremental selection
- **Terminal** — ToggleTerm floating terminal with fish shell
- **Discord presence** via cord.nvim
- **Dashboard** with randomized ASCII art headers

---

## 📁 Plugin Architecture

```
~/.config/nvim/
├── init.lua                    # Shell, undo, terminal setup → loads config/
├── lua/
│   ├── config/
│   │   ├── init.lua            # lazy.nvim bootstrap + plugin loader
│   │   ├── options.lua         # Editor options (tabs, search, folds, etc.)
│   │   ├── keymaps.lua         # Global keybindings (leader = Space)
│   │   ├── autocmds.lua        # Auto-trim, yank highlight, scroll EOF fix
│   │   └── plugin-status.lua   # Central enable/disable registry for plugins
│   ├── plugins/
│   │   ├── lsp/
│   │   │   ├── lspconfig.lua   # LSP server configurations (14 servers)
│   │   │   └── mason.lua       # Mason auto-install for LSP + tools
│   │   ├── nvim-cmp.lua        # Completion engine (Copilot + LSP + snippets)
│   │   ├── snacks.lua          # Picker, explorer, zen mode, notifications
│   │   ├── treesitter.lua      # Syntax + autotag
│   │   ├── nvim-dap.lua        # Debug adapter protocol
│   │   ├── conform.lua         # Formatter (prettier, stylua, gofmt, etc.)
│   │   ├── git-stuff.lua       # Fugitive + Gitsigns + vim-illuminate + LazyGit
│   │   ├── mini.lua            # mini.comment, mini.files, mini.surround, etc.
│   │   └── ...                 # 20+ additional plugin configs
│   └── util/
│       ├── keymapper.lua       # Keymap helper utilities
│       ├── lsp.lua             # LSP on_attach with Lspsaga bindings
│       └── autoheaders.lua     # Randomized dashboard ASCII headers
```

---

## ⌨️ Keybindings

> Leader key: `Space`

### Navigation & Files

| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>pf` | Find files (Snacks picker) |
| `<leader>ps` | Grep search                |
| `<leader>pc` | Find config files          |
| `<leader>o`  | Open Oil file manager      |
| `<leader>-`  | Oil floating window        |
| `<leader>ee` | Mini file explorer         |
| `<leader>es` | Snacks explorer            |

### Harpoon (File Marks)

| Key                                   | Action              |
| ------------------------------------- | ------------------- |
| `<leader>a`                           | Add file to harpoon |
| `<C-e>`                               | Toggle harpoon menu |
| `<C-y>` / `<M-i>` / `<C-n>` / `<M-s>` | Jump to mark 1–4    |

### LSP

| Key          | Action              |
| ------------ | ------------------- |
| `K`          | Hover documentation |
| `<leader>gd` | Peek definition     |
| `<leader>gD` | Go to definition    |
| `<leader>ca` | Code action         |
| `<leader>rn` | Rename symbol       |
| `<leader>fd` | Find references     |
| `<leader>lD` | Line diagnostics    |
| `<leader>ld` | Cursor diagnostics  |
| `<leader>cf` | Format file         |

### Git

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>gg` | Fugitive status   |
| `<leader>lg` | LazyGit TUI       |
| `<leader>gs` | Stage hunk        |
| `<leader>gr` | Reset hunk        |
| `<leader>gp` | Preview hunk      |
| `<leader>gB` | Toggle line blame |
| `]h` / `[h`  | Next/prev hunk    |

### Debug (DAP)

| Key                         | Action                       |
| --------------------------- | ---------------------------- |
| `<F5>`                      | Continue (loads launch.json) |
| `<F10>` / `<F11>` / `<F12>` | Step over/into/out           |
| `<leader>db`                | Toggle breakpoint            |
| `<leader>du`                | Toggle DAP UI                |

### General

| Key                         | Action                    |
| --------------------------- | ------------------------- |
| `<leader>sv` / `<leader>sh` | Vertical/horizontal split |
| `<M-j>` / `<M-k>`           | Move line down/up         |
| `s` / `S`                   | Flash jump / treesitter   |
| `<leader>zz`                | Zen mode (Snacks)         |
| `<c-\>`                     | Toggle floating terminal  |
| `<leader>s`                 | Replace word under cursor |

---

## 🚀 Installation

### Prerequisites

- **Neovim** ≥ 0.10
- **Git**
- **Fish shell** (configured as default shell)
- **A Nerd Font** for icons
- **ripgrep** for grep search
- **Node.js** for LSP servers and formatters
- **Go**, **Rust**, **Deno** (optional, for language-specific tooling)

### Setup

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/EricSiwakoti/nvim-config.git ~/.config/nvim

# Launch Neovim — lazy.nvim auto-installs on first run
nvim
```

On first launch, lazy.nvim will bootstrap itself and install all plugins. Mason will auto-install configured LSP servers and tools. Run `:checkhealth` to verify everything is working.

### Plugin Management

```
:Lazy          — Plugin manager UI (install, update, clean)
:Mason         — LSP/tool installer UI
:LspInfo       — Active LSP server status
```

### Toggle Plugins

Edit `lua/config/plugin-status.lua` to enable/disable any plugin without removing its configuration file:

```lua
-- Core Git integrations (Fugitive, Gitsigns, LazyGit, etc.)
["git-stuff"] = true, --enabled
-- Harpoon file marks
["harpoon"] = true, --enabled
-- Highlight references under cursor
["illuminate"] = true, --enabled
-- Floating statusline
["incline"] = false, --disabled
-- Indentation guides
["indent-blankline"] = true, --enabled
-- LSP UI enhancements
["lspsaga"] = true, --enabled
-- Statusline
["lualine"] = true, --enabled
-- mini.nvim modules (comment, files, surround, etc.)
["mini"] = false, --disabled
```

---

<p align="center">
  <sub>Built with ❤️ and Lua</sub>
</p>
