-- Fun: make your code rain or scramble with cellular automaton animations
local mapkey = require("util.keymapper").maplazykey

return {
    "eandrju/cellular-automaton.nvim",
    enabled = plugin_enabled("cellular-automaton"),
    cmd = "CellularAutomaton",
    keys = {
        mapkey("<leader>fmr", "CellularAutomaton make_it_rain", "Make it rain"),
        mapkey("<leader>gol", "CellularAutomaton game_of_life", "Game of life"),
    },
}
