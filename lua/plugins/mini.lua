return {
{
    "echasnovski/mini.nvim",
    enabled = plugin_enabled("mini"),
    version = false,
    priority = 1000,
},

{
    -- Language-aware comment toggling via ts-context-commentstring
    "echasnovski/mini.comment",
    enabled = plugin_enabled("mini"),
    version = false,
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require('ts_context_commentstring').setup {
            enable_autocmd = false,
        }

        require("mini.comment").setup {
            options = {
                -- Resolves correct comment string for embedded languages (JSX, HTML, etc.)
                custom_commentstring = function()
                    return require('ts_context_commentstring.internal').calculate_commentstring({ key = 'commentstring' })
                        or vim.bo.commentstring
                end,
            },
        }
    end
},

{
    -- Lightweight file explorer (alternative to oil for quick edits)
    "echasnovski/mini.files",
    enabled = plugin_enabled("mini"),
    config = function()
        local MiniFiles = require("mini.files")
        MiniFiles.setup({
            mappings = {
                go_in = "<CR>",
                go_in_plus = "L",
                go_out = "-",
                go_out_plus = "H",
            },
        })

        vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
        vim.keymap.set("n", "<leader>ef", function()
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
            MiniFiles.reveal_cwd()
        end, { desc = "Open mini file explorer at current file" })
    end,
},

{
    -- Surround management (brackets, quotes, tags)
    "echasnovski/mini.surround",
    enabled = plugin_enabled("mini"),
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        custom_surroundings = nil,
        highlight_duration = 300,
        mappings = {
            add = 'sa',
            delete = 'ds',
            find = 'sf',
            find_left = 'sF',
            highlight = 'sh',
            replace = 'sr',
            update_n_lines = 'sn',
            suffix_last = 'l',
            suffix_next = 'n',
        },
        n_lines = 20,
        respect_selection_type = false,
        search_method = 'cover',
        silent = false,
    },
},

{
    -- Split/join arguments, lists, etc.
    "echasnovski/mini.splitjoin",
    enabled = plugin_enabled("mini"),
    config = function()
        local miniSplitJoin = require("mini.splitjoin")
        miniSplitJoin.setup({
            mappings = { toggle = "" },
        })

        vim.keymap.set({ "n", "x" }, "sj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
        vim.keymap.set({ "n", "x" }, "sk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
    end,
},
}
