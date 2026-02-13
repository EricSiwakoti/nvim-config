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
        -- Safe require helper to prevent crashes if modules are missing
        local function safe_require(module)
            local success, result = pcall(require, module)
            if not success then
                vim.notify("Failed to require: " .. module, vim.log.levels.WARN)
                return nil
            end
            return result
        end

        -- Load required modules with error handling
        local cmp_nvim_lsp = safe_require("cmp_nvim_lsp")
        if not cmp_nvim_lsp then
            return
        end

        local schemastore = safe_require("schemastore")
        if not schemastore then
            return
        end

        local util_lsp = safe_require("util.lsp")
        if not util_lsp then
            return
        end

        local lsp_util = safe_require("lspconfig.util")
        if not lsp_util then
            return
        end

        -- Configure diagnostic display settings
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        }

        -- Apply diagnostic configuration globally
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

        -- Customize hover documentation window
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        -- Customize signature help window
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

        -- Generic function to setup an LSP server with error handling
        local function setup_server(server_name, server_config)
            local success_setup = pcall(function()
                local capabilities = cmp_nvim_lsp.default_capabilities()
                local config = vim.tbl_deep_extend("force", {
                    on_attach = util_lsp.on_attach,
                    capabilities = capabilities,
                }, server_config)

                vim.lsp.config(server_name, config)
                vim.lsp.enable(server_name)
            end)

            if not success_setup then
                vim.notify("Failed to setup " .. server_name, vim.log.levels.WARN)
            end
        end

        -- Define configurations for various LSP servers
        local servers = {
            -- Lua language server configuration
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
            -- CSS language server configuration
            cssls = {
                filetypes = { "css", "scss", "less" },
            },
            -- Tailwind CSS language server configuration
            tailwindcss = {
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
                root_dir = lsp_util.root_pattern(
                    "tailwind.config.js",
                    "tailwind.config.cjs",
                    "tailwind.config.ts"
                ),
            },
            -- Go language server configuration
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
            -- Emmet language server for web development shortcuts
            emmet_ls = {
                filetypes = {
                    "html",
                    "typescriptreact",
                    "javascriptreact",
                    "css",
                    "sass",
                    "scss",
                    "less",
                    "svelte",
                    "vue",
                },
            },
            -- JSON language server with schema support
            jsonls = {
                filetypes = { "json", "jsonc" },
                settings = {
                    json = {
                        schemas = schemastore.json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            -- TypeScript/JavaScript language server
            ts_ls = {
                root_dir = function(fname)
                    return not lsp_util.root_pattern("deno.json", "deno.jsonc")(fname)
                        and lsp_util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
                end,
                single_file_support = false,
                init_options = {
                    preferences = {
                        includeCompletionsWithSnippetText = true,
                        includeCompletionsForImportStatements = true,
                    },
                },
            },
            -- Bash language server
            bashls = {
                filetypes = { "sh", "bash" },
            },
            -- YAML language server with schema support
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
            -- Dockerfile language server
            dockerls = {
                filetypes = { "dockerfile" },
            },
            -- Markdown language server
            marksman = {
                filetypes = { "markdown" },
            },
            -- Rust language server
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
        }

        -- Iterate through all server configurations and set them up using vim.lsp.config
        for server_name, server_config in pairs(servers) do
            setup_server(server_name, server_config)
        end
    end,
}
