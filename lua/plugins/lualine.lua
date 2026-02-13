local config = function()
    local lualine = require("lualine")

    -- Define Custom Colors
    local colors = {
        color0 = "#092236",
        color1 = "#ff5874",
        color2 = "#c3ccdc",
        color3 = "#1c1e26",
        color6 = "#a1aab8",
        color7 = "#828697",
        color8 = "#ae81ff",
    }

    -- Create Custom Theme
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
        }
    }

    -- Enhanced Mode Display
    local mode = {
        'mode',
        fmt = function(str)
            return ' ' .. str:sub(1, 1)
        end,
    }

    -- Git Changes Display
    local diff = {
        'diff',
        colored = true,
        symbols = {
            added = ' ',
            modified = ' ',
            removed = ' '
        },
    }

    -- Git Branch Display
    local branch = {
        'branch',
        icon = {'', color = {fg = '#A6D4DE'}},
    }

    -- Lualine Setup
    lualine.setup({
        icons_enabled = true,
        options = {
            theme = my_lualine_theme,
            globalstatus = true,
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { mode },
            lualine_b = { branch, diff },
            lualine_c = { "buffers" },
            lualine_x = {
                "encoding",
                "fileformat",
                "filetype"
            },
            lualine_y = { "progress" },
            lualine_z = {
                "location",
                function()
                    return os.date("%H:%M:%S")
                end
            },
        },
        tabline = {},
        extensions = { "fugitive" },
    })
end

return {
    "nvim-lualine/lualine.nvim",
    enabled = plugin_enabled("lualine"),
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/noice.nvim",
    },
    lazy = false,
    config = config
}
