-- Copilot-CMP: bridges Copilot suggestions into the nvim-cmp completion menu
return {
    "zbirenbaum/copilot-cmp",
    enabled = plugin_enabled("copilot-cmp"),
    event = "InsertEnter",
    dependencies = {
        "zbirenbaum/copilot.lua",
        "hrsh7th/nvim-cmp",
    },
    opts = {},
}
