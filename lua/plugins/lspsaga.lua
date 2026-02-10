-- Lspsaga: enhanced LSP UI (hover, rename, code actions, breadcrumbs)
return {
    "nvimdev/lspsaga.nvim",
    enabled = plugin_enabled("lspsaga"),
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("lspsaga").setup({})
    end,
}
