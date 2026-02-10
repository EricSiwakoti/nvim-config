-- Bootstrap: shell, undo directory, and global keymaps before loading config

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
vim.keymap.set('n', '<leader>ch', function()
  local shada_path = vim.fn.stdpath("data") .. "/shada/main.shada"
  local success = vim.fn.delete(shada_path)

  if success == 0 then
    vim.notify("Command and search history cleared!", vim.log.levels.INFO, { title = "Shada" })
  else
    vim.notify("No shada file found or failed to delete.", vim.log.levels.WARN, { title = "Shada" })
  end
end, { desc = "Clear command history (Shada)", silent = true })

-- Load config after all base options are set
require("config")
