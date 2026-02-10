-- GitHub Copilot: AI code suggestions (runs as a cmp source via copilot-cmp)
return {
    "zbirenbaum/copilot.lua",
    enabled = plugin_enabled("copilot"),
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require('copilot').setup({
            -- Disabled: copilot-cmp provides completions through the cmp menu instead
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = false,
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                    dismiss = false,
                },
            },
            panel = {
                enabled = false
            },
            filetypes = {
                ["*"] = true
            }
        })
    end
}
