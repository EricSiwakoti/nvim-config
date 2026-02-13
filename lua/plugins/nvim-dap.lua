-- DAP: debug adapter protocol client with UI, virtual text, and mason integration
return {
    -- Core DAP plugin
    {
        "mfussenegger/nvim-dap",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local dap = require("dap")

            -------------------------------------------------------------------
            -- Key Mappings
            -------------------------------------------------------------------
            vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP: Continue" })
            vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP: Step Over" })
            vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP: Step Into" })
            vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP: Step Out" })
            vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "DAP: Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "DAP: Log Point" })
            vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "DAP: Toggle REPL" })
            vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "DAP: Terminate" })
            vim.keymap.set("n", "<leader>dc", function() dap.run_to_cursor() end, { desc = "DAP: Run to Cursor" })

            -------------------------------------------------------------------
            -- Custom Commands
            -------------------------------------------------------------------
            vim.api.nvim_create_user_command("DapDisconnect", function()
                dap.disconnect()
                dap.close()
                local ok, dapui = pcall(require, "dapui")
                if ok then
                    dapui.close()
                end
            end, { desc = "Disconnect DAP and close UI" })

            -------------------------------------------------------------------
            -- Sign Definitions
            -------------------------------------------------------------------
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "WarningMsg" })
            vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Visual", linehl = "CursorLine" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "Comment" })

            -------------------------------------------------------------------
            -- Go (Delve)
            -------------------------------------------------------------------
            dap.adapters.go = {
                type = "executable",
                command = "dlv",
                args = { "dap" },
            }

            dap.configurations.go = {
                {
                    type = "go",
                    name = "Debug: Current File",
                    request = "launch",
                    program = "${file}",
                },
                {
                    type = "go",
                    name = "Debug: Current Package",
                    request = "launch",
                    program = "${fileDirname}",
                },
                {
                    type = "go",
                    name = "Debug: Test Current File",
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                },
                {
                    type = "go",
                    name = "Debug: Attach to Process",
                    request = "attach",
                    mode = "local",
                    processId = function()
                        return require("dap.utils").pick_process()
                    end,
                },
            }

            -------------------------------------------------------------------
            -- Rust (codelldb)
            -------------------------------------------------------------------
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.rust = {
                {
                    name = "Debug: Current File",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Debug: Attach to Process",
                    type = "codelldb",
                    request = "attach",
                    pid = function()
                        return require("dap.utils").pick_process()
                    end,
                },
            }

            -------------------------------------------------------------------
            -- JavaScript & TypeScript (js-debug-adapter / pwa-node)
            -------------------------------------------------------------------
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "js-debug-adapter",
                    args = { "${port}" },
                },
            }

            dap.configurations.javascript = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug: Current File",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                    skipFiles = { "<node_internals>/**" },
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Debug: Attach to Process",
                    cwd = "${workspaceFolder}",
                    processId = function()
                        return require("dap.utils").pick_process()
                    end,
                    skipFiles = { "<node_internals>/**" },
                },
            }

            dap.configurations.typescript = dap.configurations.javascript
            dap.configurations.typescriptreact = dap.configurations.javascript
            dap.configurations.javascriptreact = dap.configurations.javascript
        end,
    },

    -- Async utilities (required for dap-ui)
    {
        "nvim-neotest/nvim-nio",
        enabled = plugin_enabled("nvim-dap"),
        lazy = true,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "◆" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Auto-open/close UI
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            -- Keymaps
            vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP: Toggle UI" })
            vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "DAP: Evaluate" })
            vim.keymap.set("v", "<leader>de", function() dapui.eval() end, { desc = "DAP: Evaluate Selection" })
        end,
    },

    -- Mason integration
    {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "codelldb", "js-debug-adapter" },
                automatic_installation = true,
            })
        end,
    },

    -- Virtual text for variables
    {
        "theHamsta/nvim-dap-virtual-text",
        enabled = plugin_enabled("nvim-dap"),
        dependencies = { "mfussenegger/nvim-dap" },
        opts = {
            highlight_changed_variables = true,
            show_stop_reason = true,
            virt_text_pos = "eol",
        },
    },
}
