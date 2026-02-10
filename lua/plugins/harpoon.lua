return {
    "thePrimeagen/harpoon",
    enabled = plugin_enabled("harpoon"),
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon add file" })

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon menu" })

        -- Quick file mark slots (1-4)
        vim.keymap.set("n", "<C-y>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon goto 1" })

        -- Avoid <C-i> as it conflicts with jumplist forward (<Tab>)
        vim.keymap.set("n", "<M-i>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon goto 2" })

        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon goto 3" })

        vim.keymap.set("n", "<M-s>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon goto 4" })

        -- Cycle through harpoon list
        vim.keymap.set("n", "<C-S-P>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon prev" })

        vim.keymap.set("n", "<C-S-N>", function()
            harpoon:list():next()
        end, { desc = "Harpoon next" })
    end,
}
