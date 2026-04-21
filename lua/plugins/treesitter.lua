-- Treesitter: syntax highlighting, incremental selection, and text objects
return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = plugin_enabled("treesitter"),
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "yaml",
        "html",
        "css",
        "http",
        "prisma",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "rust",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
        },
      },
      additional_vim_regex_highlighting = false,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    enabled = plugin_enabled("nvim-ts-autotag"),
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false, -- close tags when you type </>
      },
    },
  },
}
