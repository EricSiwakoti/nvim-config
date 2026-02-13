-- Which-key: popup showing pending keybindings after pressing leader/prefix
return {
    "folke/which-key.nvim",
    enabled = plugin_enabled("which-key"),
    lazy = false,
    opts = {
        preset = "modern",
        delay = 500,
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        win = {
            border = "rounded", -- none, single, double, rounded, solid, shadow
        },
    },
}
