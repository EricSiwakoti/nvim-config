-- Tailwind colorizer: inline color swatches in buffers and cmp completions
return {
    -- Main colorizer plugin
    {
        "NvChad/nvim-colorizer.lua",
        enabled = plugin_enabled("tailwind-colorizer"),
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    tailwind = true,
                },
                filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue" },
            })
        end,
    },
    -- Tailwind-specific colorizer extension
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        enabled = plugin_enabled("tailwind-colorizer-ext"),
        dependencies = { "NvChad/nvim-colorizer.lua" },
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    },
}
