-- Editor options: tabs, search, appearance, folds, and misc settings
local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = "split"

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = '100'
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"
-- opt.laststatus = 2
-- opt.showtabline = 2

-- Behaviour
opt.hidden = true       -- Allow hidden buffers
opt.autoread = true     -- Re-read files changed outside vim
opt.autowrite = true    -- Auto save before :next, :make, etc.
opt.wildmenu = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.selection = "exclusive"
opt.mouse = "a"
opt.modifiable = true
opt.encoding = "UTF-8"
opt.showmode = false    -- Lualine handles mode display
opt.updatetime = 100    -- Faster CursorHold events (default 4000ms)
opt.iskeyword:append('-')
opt.clipboard:append("unnamedplus")
opt.backspace = "indent,eol,start"
opt.wildmode = "longest:full,full"
opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folds (fallback when nvim-ufo is unavailable)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
