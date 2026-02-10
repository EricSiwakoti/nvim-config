-- Auto-close brackets, quotes, and HTML tags
return {
    "windwp/nvim-autopairs",
    enabled = plugin_enabled("autopairs"),
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                typescript = { "template_string" },
                java = false,
            },
        })

        -- Integrate with nvim-cmp confirm_done event
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
