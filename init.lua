-- Bootstrap: shell, undo directory, and global keymaps before loading config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set shell options
vim.o.shell = "fish"
vim.o.shellcmdflag = "-N -c"
vim.o.shellredir = ">%s 2>&1"
vim.o.shellpipe = "2>&1| tee"

-- Set history size
vim.o.history = 50

-- Define undodir
local undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir

-- Clear shada/history
vim.keymap.set("n", "<leader>ch", function()
  -- Clear in-memory histories
  vim.fn.histdel(":")
  vim.fn.histdel("/")
  vim.fn.histdel("=")

  -- Resolve shada file path correctly
  local shada_path = vim.o.shadafile
  if shada_path == "" then
    shada_path = vim.fn.stdpath("state") .. "/shada/main.shada"
  end

  -- Delete persisted shada file if present
  if vim.fn.filereadable(shada_path) == 1 then
    vim.fn.delete(shada_path)
  end

  -- Write clean shada state
  vim.cmd("wshada!")

  vim.notify("Command/search history cleared", vim.log.levels.INFO, { title = "Shada" })
end, { desc = "Clear command/search history (Shada)", silent = true })

-- Load config after all base options are set
require("config")
