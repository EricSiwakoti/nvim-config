-- LSP on_attach: sets buffer-local keymaps (via Lspsaga) when an LSP client attaches
local mapkey = require("util.keymapper").mapvimkey

local M = {}

M.on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- LSP key mappings (Lspsaga-based)
    mapkey("<leader>fd", "Lspsaga finder", "n", opts)
    mapkey("<leader>gd", "Lspsaga peek_definition", "n", opts)
    mapkey("<leader>gD", "Lspsaga goto_definition", "n", opts)
    mapkey("<leader>gi", "lua vim.lsp.buf.implementation()", "n", opts)
    mapkey("<leader>ca", "Lspsaga code_action", "n", opts)
    mapkey("<leader>rn", "Lspsaga rename", "n", opts)
    mapkey("<leader>lD", "Lspsaga show_line_diagnostics", "n", opts)
    mapkey("<leader>ld", "Lspsaga show_cursor_diagnostics", "n", opts)
    mapkey("<leader>pd", "Lspsaga diagnostic_jump_prev", "n", opts)
    mapkey("<leader>nd", "Lspsaga diagnostic_jump_next", "n", opts)
    mapkey("K", "Lspsaga hover_doc", "n", opts)
end

return M
