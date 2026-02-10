-- Toggleterm: floating terminal overlay with fish shell (toggle with <C-\>)
return {
    "akinsho/toggleterm.nvim",
    enabled = plugin_enabled("toggleterm"),
    version = "*",
    lazy = false,
    config = function()
        require("toggleterm").setup({
            size = 10,
            open_mapping = [[<c-\>]],
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            close_on_exit = false,
            persist_size = true,
            direction = "float",
            float_opts = {
                border = "curved",
                winblend = 0,
            },
            highlights = {
                border = "Normal",
                background = "Normal",
                FloatBorder = {
                    guifg = "#208397"
                }
            },
            shell = "fish",
        })

        -- Clean terminal buffer appearance
        vim.api.nvim_create_autocmd('TermOpen', {
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn = 'no'
            end,
        })
    end,
}
