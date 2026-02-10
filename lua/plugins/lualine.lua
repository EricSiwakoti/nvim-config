-- Lualine: statusline with git branch, diagnostics, filetype, and progress
return {
    "nvim-lualine/lualine.nvim",
    enabled = plugin_enabled("lualine"),
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/noice.nvim",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        -- Custom theme colors
        local colors = {
            color0 = "#092236",
            color1 = "#ff5874",
            color2 = "#c3ccdc",
            color3 = "#1c1e26",
            color6 = "#a1aab8",
            color7 = "#828697",
            color8 = "#ae81ff",
        }

        local my_lualine_theme = {
            normal = {
                a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
                b = { fg = colors.color2, bg = colors.color3 },
                c = { fg = colors.color2, bg = colors.color3 },
            },
            insert = {
                a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
            },
            visual = {
                a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
            },
            replace = {
                a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
            },
            inactive = {
                a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
                b = { fg = colors.color6, bg = colors.color3 },
                c = { fg = colors.color6, bg = colors.color3 },
            },
        }

        -- Custom components
        local mode = {
            'mode',
            fmt = function(str)
                return ' ' .. str:sub(1, 1)
            end,
        }

        local diff = {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
        }

        local filename = {
            'filename',
            file_status = true,
            path = 0,
        }

        local branch = {
            'branch',
            icon = {'', color = {fg = '#A6D4DE'}},

        }

        lualine.setup({
            icons_enabled = true,
            options = {
                theme = my_lualine_theme,
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "|", right = " " },
                globalstatus = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { diff, filename },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location", function()
                    return os.date("%H:%M:%S")
                end },
            },
            tabline = {},
            extensions = { "fugitive" },
        })
    end,
}
