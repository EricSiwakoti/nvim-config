-- Peek: live Markdown preview in the browser
return {
    "toppair/peek.nvim",
    enabled = plugin_enabled("peek"),
    build = "deno task --quiet build:fast",
    keys = {
        {
            "<leader>po",
            function()
                local peek = require("peek")
                peek.setup({
                    app = "browser",
                    filetypes = { "markdown" },
                })
                vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
                vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
                if peek.is_open() then
                    peek.close()
                else
                    peek.open()
                end
            end,
            desc = "Toggle Markdown Preview",
        },
    },
}
