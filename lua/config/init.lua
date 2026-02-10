-- Bootstrap lazy.nvim plugin manager and load all plugin specs
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('config.autocmds')
require('config.keymaps')
require('config.options')
require('config.plugin-status')

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = {"carbonfox"}
	},
	checker = { enabled = true },
	change_detection = {
		notify = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"shada",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.lsp" },
}, opts)
