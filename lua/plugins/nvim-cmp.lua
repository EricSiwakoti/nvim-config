-- Nvim-CMP: autocompletion engine with LSP, snippets, copilot, and path sources
return {
    "hrsh7th/nvim-cmp",
    enabled = plugin_enabled("nvim-cmp"),
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-buffer",      -- Text in current buffer
        "hrsh7th/cmp-path",        -- File system paths
        "saadparwaiz1/cmp_luasnip", -- Snippets
        "hrsh7th/cmp-nvim-lsp",    -- LSP completions
        "onsails/lspkind.nvim",    -- VS Code-like pictograms
        "L3MON4D3/LuaSnip",        -- Snippet engine
        "rafamadriz/friendly-snippets", -- Pre-defined snippets
        "zbirenbaum/copilot-cmp",  -- Copilot integration
        "roobert/tailwindcss-colorizer-cmp.nvim", -- Tailwind CSS color preview
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local colorizer = require("tailwindcss-colorizer-cmp").formatter

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Priority order: Copilot > LSP/Snippets > Buffer/Path
            sources = cmp.config.sources({
                { name = "copilot", group_index = 1 }, -- Copilot first
                { name = "nvim_lsp", group_index = 2 }, -- LSP next
                { name = "luasnip", group_index = 2 }, -- Snippets
                { name = "buffer", group_index = 3 }, -- Buffer last
                { name = "path", group_index = 3 },
                { name = "tailwindcss-colorizer-cmp", group_index = 3 }, -- Tailwind colors
            }),

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            formatting = {
                format = function(entry, vim_item)
                    vim_item = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    })(entry, vim_item)

                    -- Apply tailwind color preview for LSP entries
                    if entry.source.name == "nvim_lsp" then
                        vim_item = colorizer(entry, vim_item)
                    end

                    vim_item.menu = ({
                        copilot = "[Copilot]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        ["tailwindcss-colorizer-cmp"] = "",
                    })[entry.source.name] or ""

                    return vim_item
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
    end,
}
