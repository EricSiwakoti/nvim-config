-- Cord: Discord Rich Presence integration for Neovim
return {
    "vyfor/cord.nvim",
    enabled = plugin_enabled("cord"),
    event = "VeryLazy",
    config = function()
        require('cord').setup({
            client_id = "1157438236723200000",
            scope = "activities.write",
            timeout = 10000,
            log_level = "error",

            details = "Editing $file_name",
            state = "In $directory",
            large_image = "neovim",
            large_text = "Editing $file_name",
            small_image = "default",
            small_text = "Neovim",

            show_time = true,
            show_directory = true,
            show_file_name = true,
            show_file_icon = true,
            show_workspace = true,

            idle_timeout = 0, -- Set to a value in seconds if you want idle status
        })
    end,
}
