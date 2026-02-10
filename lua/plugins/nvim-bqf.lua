-- Better quickfix: preview windows, fuzzy search, and enhanced navigation in qf lists
return {
    "kevinhwang91/nvim-bqf",
    enabled = plugin_enabled("nvim-bqf"),
    event = "BufRead",
    config = function()
        require('bqf').setup({
            auto_enable = true,
            preview = {
                win_height = 12,
                win_vheight = 12,
                delay_syntax = 80,
                threshold = 49,
                auto_preview = true,
            },
            func_map = {
                vsplit = '',
                ptogglemode = 'z,',
                stoggleup = '',
                filter = '',
                filterr = '',
                fzffilter = '',
            },
            filter = {
                fzf = {
                    action_for = { ['ctrl-s'] = 'split' },
                    extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
                }
            }
        })

        -- Open BQF quickfix window
        vim.keymap.set('n', '<leader>b', '<cmd>Bqf<CR>',
            { noremap = true, silent = true, desc = "Open BQF quickfix" })
    end
}
