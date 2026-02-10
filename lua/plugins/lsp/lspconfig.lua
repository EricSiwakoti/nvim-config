-- LSP configuration: per-server setup, diagnostics, and capabilities
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "b0o/schemastore.nvim",
    },
    config = function()
        -- Safe require to avoid crashes on missing modules
        local function safe_require(module)
            local success, result = pcall(require, module)
            if not success then
                vim.notify("Failed to require: " .. module, vim.log.levels.WARN)
                return nil
            end
            return result
        end

        local lspconfig = safe_require("lspconfig")
        if not lspconfig then return end

        local cmp_nvim_lsp = safe_require("cmp_nvim_lsp")
        if not cmp_nvim_lsp then return end

        local schemastore = safe_require("schemastore")
        if not schemastore then return end

        local util_lsp = safe_require("util.lsp")
        if not util_lsp then return end

        -- Diagnostic configuration
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        }

        vim.diagnostic.config({
            signs = { text = signs },
            virtual_text = true,
            underline = true,
            update_in_insert = false,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })

        -- Customize LSP float borders
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded"
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded"
        })

        -- Reduce duplication when setting up servers
        local function setup_server(server_name, server_config)
            local success = pcall(function()
                local capabilities = cmp_nvim_lsp.default_capabilities()
                local config = vim.tbl_deep_extend("force", {
                    on_attach = util_lsp.on_attach,
                    capabilities = capabilities,
                }, server_config)
                lspconfig[server_name].setup(config)
            end)

            if not success then
                vim.notify("Failed to setup " .. server_name, vim.log.levels.WARN)
            end
        end

        -- Server configurations
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            },
            cssls = {
                filetypes = { "css", "scss", "less" },
            },
            tailwindcss = {
                filetypes = {
                    "html", "css", "scss", "javascript", "javascriptreact",
                    "typescript", "typescriptreact", "vue", "svelte"
                },
                root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
            },
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },
            emmet_ls = {
                filetypes = {
                    "html", "typescriptreact", "javascriptreact", "css", "sass",
                    "scss", "less", "svelte", "vue",
                },
            },
            jsonls = {
                filetypes = { "json", "jsonc" },
                settings = {
                    json = {
                        schemas = schemastore.json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            ts_ls = {
                root_dir = function(fname)
                    local util = lspconfig.util
                    return not util.root_pattern("deno.json", "deno.jsonc")(fname)
                        and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
                end,
                single_file_support = false,
                init_options = {
                    preferences = {
                        includeCompletionsWithSnippetText = true,
                        includeCompletionsForImportStatements = true,
                    },
                },
            },
            bashls = {
                filetypes = { "sh", "bash" },
            },
            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = schemastore.yaml.schemas(),
                    },
                },
            },
            dockerls = {
                filetypes = { "dockerfile" },
            },
            marksman = {
                filetypes = { "markdown" },
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
            clangd = {
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            },
        }

        -- Setup all servers
        for server_name, server_config in pairs(servers) do
            setup_server(server_name, server_config)
        end
    end,
}
