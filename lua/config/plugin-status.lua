-- Central plugin enable/disable registry
-- Set to false to disable a plugin without deleting its config file
local plugin_status = {
    ["autopairs"] = true,
    ["cellular-automaton"] = true,
    ["codecompanion"] = true,
    ["conform"] = true,
    ["copilot-cmp"] = true,
    ["copilot"] = true,
    ["cord"] = true,
    ["dashboard"] = true,
    ["flash"] = true,
    ["git-stuff"] = true,
    ["harpoon"] = true,
    ["illuminate"] = true,
    ["incline"] = false,
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
    ["nvim-ufo"] = true,
    ["oil"] = true,
    ["peek"] = true,
    ["snacks"] = true,
    ["tailwind-colorizer"] = true,
    ["tailwind-colorizer-ext"] = true,
    ["todo-comments"] = false,
    ["toggleterm"] = true,
    ["treesitter"] = true,
    ["trouble"] = true,
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
