-- Mason: auto-install LSP servers, formatters, linters, and DAP adapters
return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "cssls",
                "tailwindcss",
                "gopls",
                "emmet_ls",
                "jsonls",
                "ts_ls",
                "bashls",
                "yamlls",
                "dockerls",
                "marksman",
                "rust_analyzer",
                "clangd",
            },
        })

        mason_tool_installer.setup({
            automatic_installation = true,
            ensure_installed = {
                "prettier",
                "stylua",
                "eslint_d",
                "gofmt",
                "goimports",
                "shfmt",
                "shellcheck",
                "rustfmt",
                "clang-format",
                "hadolint",
            },
        })
    end,
}
