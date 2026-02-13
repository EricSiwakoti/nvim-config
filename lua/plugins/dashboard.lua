-- Dashboard: startup screen with recent files, projects, and shortcuts
return {
    "nvimdev/dashboard-nvim",
    enabled = plugin_enabled("dashboard"),
    event = "VimEnter",
    opts = function()
        -- Fetch the logo/header from your custom autoheaders utility
        local logo = require('util.autoheaders').dashboard()

        local opts = {
            theme = "doom",
            hide = {
                statusline = false,
            },
            config = {
                -- Use the dynamic header from your autoheaders utility
                header = vim.split(logo, "\n"),

                -- Center buttons configuration
                center = {
                    -- Use snacks picker for file finding
                    {
                        action = function() Snacks.picker.files() end,
                        desc = " Find file",
                        icon = " ",
                        key = "f"
                    },
                    -- Create new file
                    {
                        action = "ene | startinsert",
                        desc = " New file",
                        icon = " ",
                        key = "n"
                    },
                    -- Use snacks picker for recent files
                    {
                        action = function() Snacks.picker.recent() end,
                        desc = " Recent files",
                        icon = " ",
                        key = "r"
                    },
                    -- Use snacks picker for text searching
                    {
                        action = function() Snacks.picker.grep() end,
                        desc = " Find text",
                        icon = " ",
                        key = "g"
                    },
                    -- Open terminal
                    {
                        action = ":terminal",
                        desc = " Open terminal",
                        icon = " ",
                        key = "o"
                    },
                    -- Open Lazy
                    {
                        action = "Lazy",
                        desc = " Lazy",
                        icon = "󰒲 ",
                        key = "p"
                    },
                    -- Open Mason
                    {
                        action = "Mason",
                        desc = " Mason",
                        icon = "󱧕 ",
                        key = "m"
                    },
                    -- Quit Neovim
                    {
                        action = "qa",
                        desc = " Quit",
                        icon = " ",
                        key = "q"
                    },
                },

                -- Footer configuration - displays dynamic info like startup time and current time
                footer = function()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    local info = {}
                    info[1] = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                    info[2] = '' -- Spacer line
                    local footer = vim.list_extend(info, { ' ' .. vim.fn.strftime('%a %d %b %I:%M %p') }) -- Add current time
                    return footer
                end,
            },
        }

        -- Styling for center buttons - adds padding and formatting
        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
            button.key_format = '  %s'
        end

        -- Closes Lazy if open and re-opens it after dashboard loads
        if vim.o.filetype == 'lazy' then
            vim.cmd.close()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'DashboardLoaded',
                callback = function() require('lazy').show() end,
            })
        end

        return opts
    end,
}
