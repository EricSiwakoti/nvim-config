-- Nightfox: colorscheme provider — using Carbonfox variant with transparent background
return {
    "EdenEast/nightfox.nvim",
    enabled = plugin_enabled("nightfox"),
    lazy = false,
    priority = 999,
    config = function()
        require('nightfox').setup({
            options = {
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    functions = "italic,bold",
                    types = "italic,bold",
                }
            }
        })
        vim.cmd("colorscheme carbonfox")
    end
}
