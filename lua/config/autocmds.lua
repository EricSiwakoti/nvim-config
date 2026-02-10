-- Autocommands: trim whitespace, yank highlight, restore cursor, auto-mkdir
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local command = vim.api.nvim_create_user_command

-- TEXT EDITING

--- Trim trailing whitespace from current buffer
local function trim_trailing_whitespace()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
    local last_line = vim.api.nvim_buf_line_count(0)
    pos[1] = math.min(pos[1], last_line)
    vim.api.nvim_win_set_cursor(0, pos)
end
--- Trim trailing blank lines from current buffer
local function trim_trailing_lines()
    local last_line = vim.api.nvim_buf_line_count(0)
    local last_nonblank_line = vim.fn.prevnonblank(last_line)
    if last_nonblank_line < last_line then
        vim.api.nvim_buf_set_lines(0, last_nonblank_line, last_line, true, {})
    end
end
--- Trim both trailing whitespace and trailing lines
local function trim_all()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
        trim_trailing_lines()
        trim_trailing_whitespace()
    end
end
-- Auto trim on save
autocmd('BufWritePre', {
    group = augroup("TrimOnSaveGroup", { clear = true }),
    callback = trim_all,
})
-- Highlight yanked text
autocmd("TextYankPost", {
    group = augroup("HighlightYankGroup", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- WINDOW & BUFFER MANAGEMENT

-- Auto resize splits when terminal window size changes
autocmd("VimResized", {
    group = augroup("WindowResizeGroup", { clear = true }),
    command = "wincmd =",
})
-- Split help buffers to the right
autocmd("FileType", {
    group = augroup("HelpWindowGroup", { clear = true }),
    pattern = "help",
    command = "wincmd L",
})

-- SCROLLING & CURSOR BEHAVIOR

-- Fix scrolloff when at EOF
autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
    group = augroup("ScrollEOF", { clear = true }),
    callback = function()
        if vim.api.nvim_win_get_config(0).relative ~= "" then
            return
        end

        local win_height = vim.fn.winheight(0)
        local scrolloff = math.min(vim.o.scrolloff, math.floor(win_height / 2))
        local visual_distance_to_eof = win_height - vim.fn.winline()

        if visual_distance_to_eof < scrolloff then
            local win_view = vim.fn.winsaveview()
            vim.fn.winrestview({
                topline = win_view.topline + scrolloff - visual_distance_to_eof
            })
        end
    end,
})
-- Auto jump to last cursor position
autocmd("BufReadPost", {
    group = augroup("AutoLastPosition", { clear = true }),
    callback = function(args)
        local buf = args.buf
        local mark = vim.api.nvim_buf_get_mark(buf, [["]])
        local line_count = vim.api.nvim_buf_line_count(buf)
        -- Only restore cursor if mark is valid and within buffer line range
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, vim.fn.bufwinid(buf), mark)
        end
    end,
})

-- FILE SYSTEM & DIRECTORIES

-- Auto create directory when saving a file
autocmd("BufWritePre", {
    group = augroup("AutoCreateDir", { clear = true }),
    callback = function(event)
        local file = event.match
        -- Skip remote protocols (e.g. ftp, http)
        if file:match("^%w%w+:[\\/][\\/]") then
            return
        end
        -- Expand and create parent directory if it doesn't exist
        local dir = vim.fn.fnamemodify(file, ":p:h")
        vim.fn.mkdir(dir, "p")
    end,
})

-- USER COMMANDS

command('TrimWhitespace', trim_trailing_whitespace, {
    desc = "Trim trailing whitespace from current buffer"
})
command('TrimTrailingLines', trim_trailing_lines, {
    desc = "Trim trailing blank lines from current buffer"
})
command('TrimAll', trim_all, {
    desc = "Trim both trailing whitespace and trailing lines"
})
