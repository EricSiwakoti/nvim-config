-- Which-key: popup showing pending keybindings after pressing leader/prefix
return {
    "folke/which-key.nvim",
    enabled = plugin_enabled("which-key"),
    lazy = false,
    opts = {
        -- Disable the plugin in certain filetypes
        preset = "modern", -- Use modern preset for better defaults
        delay = 500,       -- Delay in ms until the popup window is shown
        icons = {
            breadcrumb = "»", -- Symbol used between a key and its label
            separator = "➜",  -- Symbol used between a key and its group
            group = "+",      -- Symbol prepended to a group
        },
        win = {
            border = "rounded", -- none, single, double, rounded, solid, shadow
        },
    },
}
