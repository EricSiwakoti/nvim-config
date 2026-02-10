-- DAP: debug adapter protocol client with UI, virtual text, and mason integration
return {
    -- Core DAP plugin for debugging support
    {
        "mfussenegger/nvim-dap",
        enabled = plugin_enabled("nvim-dap"),
        config = function()
            local dap = require("dap")
            local keymap = vim.keymap.set

            -- Key mappings for DAP
            keymap("n", "<F10>", function() dap.step_over() end, { desc = "DAP step over" })
            keymap("n", "<F11>", function() dap.step_into() end, { desc = "DAP step into" })
            keymap("n", "<F12>", function() dap.step_out() end, { desc = "DAP step out" })
            keymap("n", "<F5>", function()
                if vim.fn.filereadable(".vscode/launch.json") == 1 then
                    require("dap.ext.vscode").load_launchjs()
                end
                dap.continue()
            end, { desc = "DAP continue" })
            keymap("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP toggle UI" })
            keymap("n", "<leader>dr", function()
                local dapui = require("dapui")
                dapui.close()
                dapui.open({ reset = true })
            end, { desc = "DAP reset UI" })
            keymap("n", "<leader>de", function() require("dapui").eval() end, { desc = "DAP eval" })
            keymap("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
            keymap("n", "<leader>dc", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "DAP set breakpoint with condition" })

            -- Custom command to disconnect DAP
            vim.api.nvim_create_user_command("DapDisconnect", function()
                dap.disconnect()
                require("dapui").close()
            end, {})

            -- Custom icons for breakpoints
            vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

            -- DAP adapters and configurations
            local dap_config = {
                go = {
                    adapter = {
                        type = "executable",
                        command = "dlv",
                        args = { "dap" },
                        name = "Delve",
                    },
                    configurations = {
                        {
                            type = "go",
                            name = "Debug",
                            request = "launch",
                            program = "${file}",
                        },
                    },
                },

                javascript = {
                    adapter = {
                        type = 'executable',
                        command = 'node',
                        args = { vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
                    },
                    configurations = {
                        {
                            type = 'node2',
                            request = 'launch',
                            name = 'Launch file',
                            program = "${file}",
                            sourceMaps = true,
                            protocol = 'inspector',
                            skipFiles = { "<node_internals>/**" },
                        },
                    },
                },

                typescript = {
                    adapter = {
                        type = 'executable',
                        command = 'node',
                        args = { vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
                    },
                    configurations = {
                        {
                            type = 'node2',
                            request = 'launch',
                            name = 'Launch file',
                            program = "${file}",
                            sourceMaps = true,
                            protocol = 'inspector',
                            skipFiles = { "<node_internals>/**" },
                            outFiles = { "${workspaceFolder}/dist/**/*.js" },
                        },
                    },
                },
            }

            -- Set DAP configurations
            -- Go
            dap.adapters.go = dap_config.go.adapter
            dap.configurations.go = dap_config.go.configurations

            -- JavaScript
            dap.adapters.node2 = dap_config.javascript.adapter
            dap.configurations.javascript = dap_config.javascript.configurations
            dap.configurations.typescript = dap_config.typescript.configurations
        end,
    },

    -- Async utilities for neotest (dependency for some DAP features)
    {
        "nvim-neotest/nvim-nio",
        enabled = plugin_enabled("nvim-dap"),
    },

    -- DAP UI for enhanced debugging experience
    {
        "rcarriga/nvim-dap-ui",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    -- Mason integration for DAP
    {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        config = function()
            local mason_nvim_dap = require("mason-nvim-dap")
            mason_nvim_dap.setup({
                ensure_installed = {
                    "debugpy",
                    "delve",
                    "codelldb",
                    "node-debug2-adapter",
                    "bash-debug-adapter",
                },
                automatic_installation = true,
            })
        end,
    },

    -- Virtual text for DAP variables
    {
        "theHamsta/nvim-dap-virtual-text",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
}
