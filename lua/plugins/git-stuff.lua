-- Git integration: fugitive (commands), gitsigns (gutters), vim-illuminate (word highlight)
return {
    {
        "tpope/vim-fugitive",
        enabled = plugin_enabled("git-stuff"),
        config = function()
            vim.keymap.set("n", "<leader>gg", vim.cmd.Git)

            local fugitiveGroup = vim.api.nvim_create_augroup("MyFugitive", {})

            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = fugitiveGroup,
                pattern = "*",
                callback = function()
                    if vim.bo.filetype ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git('push')
                    end, opts)

                    -- Pull with rebase
                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git({ 'pull', '--rebase' })
                    end, opts)

                    -- Set upstream branch (useful for new branches)
                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
                end,
            })
        end,
    },

    -- Gitsigns: hunk management and git decorations
    {
        "lewis6991/gitsigns.nvim",
        enabled = plugin_enabled("git-stuff"),
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- Hunk navigation
                map("n", "]h", gs.next_hunk, "Next Git hunk")
                map("n", "[h", gs.prev_hunk, "Previous Git hunk")

                -- Single hunk operations
                map("n", "<leader>gs", gs.stage_hunk, "Stage current hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset current hunk")

                -- Visual selection operations
                map("v", "<leader>gs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage selected hunk")

                map("v", "<leader>gr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset selected hunk")

                -- Buffer-wide operations
                map("n", "<leader>gS", gs.stage_buffer, "Stage entire buffer")
                map("n", "<leader>gR", gs.reset_buffer, "Reset entire buffer")
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo staged hunk")

                -- Diff and blame
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk changes")
                map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Show full blame")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
                map("n", "<leader>gd", gs.diffthis, "Diff current file")
                map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff against HEAD~1")

                -- Text object for hunks
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk text object")
            end,
        },
    },

    -- vim-illuminate: highlights references to word under cursor
    {
        "RRethy/vim-illuminate",
        enabled = plugin_enabled("illuminate"),
        lazy = false,
        config = function()
            require("illuminate").configure({})
        end,
    },
}
