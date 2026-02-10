-- CodeCompanion: AI chat and inline assistance (Copilot + Gemini adapters)
return {
    "olimorris/codecompanion.nvim",
    enabled = plugin_enabled("codecompanion"),
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
        "CodeCompanion",
        "CodeCompanionActions",
        "CodeCompanionChat",
    },
    keys = {
        { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "AI New Chat" },
        { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Toggle Chat" },
        { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Action" },
        { "ga", "<cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "AI Add to Chat" },
        { "<leader>ai", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "AI Explain" },
        { "<leader>cl", "<cmd>CodeCompanionChat Clear<CR>", mode = "n", desc = "Clear CodeCompanion Chat" },
        { "<leader>agc", "<cmd>CodeCompanionChat copilot<cr>", mode = { "n", "v" }, desc = "Switch to Copilot" },
        { "<leader>agg", "<cmd>CodeCompanionChat gemini<cr>", mode = { "n", "v" }, desc = "Switch to Gemini" },
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                copilot = {},
                gemini = {
                    api_key = vim.env.GEMINI_API_KEY,
                    model = "gemini-2.5-flash",
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot"
                },
                inline = {
                    adapter = "disabled"
                },
                agent = {
                    adapter = "copilot"
                },
            },
        })
    end,
}
