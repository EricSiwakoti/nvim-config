return {
    -- Seamless <C-h/j/k/l> navigation between Neovim and tmux panes
    -- Falls back to normal wincmd navigation when not inside tmux
    "christoomey/vim-tmux-navigator",
    enabled = plugin_enabled("vim-tmux-navigator"),
    lazy = false,
    init = function()
        if vim.env.TMUX ~= nil then
            vim.g.tmux_navigator_no_mappings = 1
        end
    end,
    config = function()
        if vim.env.TMUX ~= nil then
            vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left (tmux/vim)" })
            vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { desc = "Navigate down (tmux/vim)" })
            vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { desc = "Navigate up (tmux/vim)" })
            vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { desc = "Navigate right (tmux/vim)" })
            vim.keymap.set("n", "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate to previous pane" })
        end
    end,
}
