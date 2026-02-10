-- Conform: format-on-save using language-specific formatters
return {
    "stevearc/conform.nvim",
    enabled = plugin_enabled("conform"),
    event = "BufReadPre",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                }, function(err)
                    if err then
                        vim.notify("Format failed: " .. err, vim.log.levels.ERROR)
                    end
                end)
            end,
            mode = { "n", "v" },
            desc = "Format file or range"
        },
        {
            "<leader>ct",
            function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                print("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
            end,
            desc = "Toggle autoformat"
        },
        {
            "<leader>cT",
            function()
                vim.b.disable_autoformat = not vim.b.disable_autoformat
                print("Buffer autoformat " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
            end,
            desc = "Toggle buffer autoformat"
        },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", 4 }
                },
                prettier = {
                    prepend_args = { "--single-quote", "--jsx-single-quote" }
                },
            },
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                graphql = { "prettier" },
                svelte = { "prettier" },
                vue = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                go = { "gofmt", "goimports" },
                rust = { "rustfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                css = { "prettier" },
                html = { "prettier" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    timeout_ms = 1000,
                    lsp_format = "fallback",
                }
            end,
        })
    end,
}
