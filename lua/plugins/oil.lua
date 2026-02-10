-- Oil.nvim: vim-style file manager that edits the filesystem like a buffer
local maplazykey = require("util.keymapper").maplazykey

return {
    {
        "stevearc/oil.nvim",
        enabled = plugin_enabled("oil"),
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Oil",
        keys = {
            maplazykey("<leader>o", "Oil", "Open Oil"),
            maplazykey("<leader>-", function() require("oil").toggle_float() end, "Open Oil Float"),
        },
        config = function()
            require('oil').setup({
                default_file_explorer = true,
                columns = {
                    "icon",
                    "size",
                    "mtime",
                },
                keymaps = {
                    ["<M-v>"] = "actions.select_vsplit",
                    ["q"] = "actions.close",
                },
                delete_to_trash = true,
                float = {
                    enable = true,
                    max_height = 20,
                    border = "rounded",
                },
                view_options = {
                    show_hidden = true,
                },
                skip_confirm_for_simple_edits = true,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function()
                    vim.opt_local.cursorline = true
                end
            })
        end
    }
}
