-- Central plugin enable/disable registry
-- Set to false to disable a plugin without deleting its config file
local plugin_status = {
    ["autopairs"] = true,
    ["cellular-automaton"] = true,
    ["conform"] = true,
    ["cord"] = true,
    ["dashboard"] = true,
    ["flash"] = true,
    ["git-stuff"] = true,
    ["harpoon"] = true,
    ["illuminate"] = true,
    ["indent-blankline"] = true,
    ["lspsaga"] = true,
    ["lualine"] = true,
    ["mini"] = true,
    ["nightfox"] = true,
    ["noice"] = true,
    ["nvim-bqf"] = true,
    ["nvim-cmp"] = true,
    ["nvim-dap"] = true,
    ["nvim-ts-autotag"] = true,
    ["oil"] = true,
    ["peek"] = true,
    ["snacks"] = true,
    ["tailwind-colorizer"] = true,
    ["tailwind-colorizer-ext"] = true,
    ["toggleterm"] = true,
    ["treesitter"] = true,
    ["vim-tmux-navigator"] = true,
    ["which-key"] = true,
    ["wilder"] = true,
}

_G.plugin_enabled = function(name)
    return plugin_status[name] == nil or plugin_status[name]
end

return {
    is_enabled = function(name)
        return plugin_status[name] == nil or plugin_status[name]
    end,
    set_enabled = function(name, value)
        plugin_status[name] = value
    end,
    status = plugin_status,
}
