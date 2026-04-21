-- Plugin-specific keymaps are defined in their respective plugin config files

local mapkey = require("util.keymapper").mapvimkey
local opts = { noremap = true, silent = true }

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n")
mapkey("<leader>bp", "bprevious", "n")
mapkey("<leader>`", "e #", "n")

-- Pane navigation (terminal mode — normal mode handled by vim-tmux-navigator)
mapkey("<C-h>", "wincmd h", "t")
mapkey("<C-j>", "wincmd j", "t")
mapkey("<C-k>", "wincmd k", "t")
mapkey("<C-l>", "wincmd l", "t")

-- Window Management
mapkey("<leader>sv", "vsplit", "n")
mapkey("<leader>sh", "split", "n")
mapkey("<C-Up>", "resize +2", "n")
mapkey("<C-Down>", "resize -2", "n")
mapkey("<C-Left>", "vertical resize +2", "n")
mapkey("<C-Right>", "vertical resize -2", "n")

-- Show full File Path
mapkey("<leader>fp", "echo expand('%:p')", "n")

-- Make File Executable
mapkey("<leader>x", "!chmod +x %", "n")

-- Indenting in visual mode (stay in visual after indent)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Disable Q
vim.keymap.set("n", "Q", "<nop>", opts)

-- Prevent x from polluting the default register
vim.keymap.set("n", "x", '"_x', opts)

-- Replace all instances of word under cursor (with confirmation prompt)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Move Lines and Code Blocks
vim.keymap.set('n', '<M-j>', ':m .+1<CR>', opts)
vim.keymap.set('n', '<M-k>', ':m .-2<CR>', opts)
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", opts)

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP diagnostics visibility" })
