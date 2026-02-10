-- Snacks.nvim: unified picker, explorer, notifications, zen mode, and utilities
local keymapper = require("util.keymapper").maplazykey

return {
    {
        "folke/snacks.nvim",
        enabled = plugin_enabled("snacks"),
        priority = 1000,
        lazy = false,
        opts = {
            styles = {
                input = {
                    keys = {
                        n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    }
                },
            },
            -- Snacks Modules
            input = {
                enabled = true,
            },
            scroll = {
                enabled = true,
            },
            zen = {
                enabled = true,
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            explorer = {
                enabled = true,
                layout = {
                    cycle = false,
                },
            },
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = false,
                },
                formatters = {
                    file = {
                        filename_first = false,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    preset = "telescope", -- Defaults to this layout unless overridden, other options are "select", "ivy"
                    cycle = false,
                },
                layouts = {
                    select = {
                        preview = false,
                        layout = {
                            backdrop = false,
                            width = 0.6,
                            min_width = 80,
                            height = 0.4,
                            min_height = 10,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                        },
                    },
                    telescope = {
                        reverse = true, -- Set to false for search bar to be on top
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags} ",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                },
            },
            image = {
                enabled = true,
                doc = {
                    float = true, -- Show image on cursor hover
                    inline = false,
                    max_width = 50,
                    max_height = 30,
                    wo = {
                        wrap = false,
                    },
                },
                convert = {
                    notify = true,
                    command = "convert"
                },
                img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments", "~/Downloads", "~/Pictures" },
            },
        },
        keys = {
            -- Git
            keymapper("<leader>lg", function() require("snacks").lazygit() end, "Lazygit"),
            keymapper("<leader>gl", function() require("snacks").lazygit.log() end, "Lazygit Logs"),
            -- File management
            keymapper("<leader>es", function() require("snacks").explorer() end, "Snacks Explorer"),
            keymapper("<leader>rN", function() require("snacks").rename.rename_file() end, "Fast Rename Current File"),
            keymapper("<leader>dB", function() require("snacks").bufdelete() end, "Delete or Close Buffer (Confirm)"),
            -- Zen mode
            keymapper("<leader>zz", function() require("snacks").zen.toggle() end, "Toggle Zen Mode"),
            -- Picker
            keymapper("<leader>pf", function() require("snacks").picker.files() end, "Find Files"),
            keymapper("<leader>pc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File"),
            keymapper("<leader>ps", function() require("snacks").picker.grep() end, "Grep word"),
            keymapper("<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, "Search Keymaps"),
            keymapper("<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, "Pick Git Branch"),
            keymapper("<leader>nh", function() require("snacks").picker.notifications() end, "Notification History"),
            keymapper("<leader>vh", function() require("snacks").picker.help() end, "Help Pages"),
            { "<leader>pws", function() require("snacks").picker.grep_word() end, desc = "Search Visual selection or Word", mode = { "n", "x" } },
        }
    },

    -- Todo Comments with Snacks
    {
        "folke/todo-comments.nvim",
        enabled = plugin_enabled("todo-comments"),
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            keymapper("<leader>pt", function() require("snacks").picker.todo_comments() end, "Todo"),
            keymapper("<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, "Todo/Fix/Fixme"),
        },
    }
}
