-- Conform: format-on-save using language-specific formatters
return {
  "stevearc/conform.nvim",
  enabled = plugin_enabled("conform"),
  event = "BufReadPre",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        }, function(err)
          if err then
            vim.notify("Format failed: " .. err, vim.log.levels.ERROR)
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
    {
      "<leader>ct",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
      end,
      desc = "Toggle global autoformat",
    },
    {
      "<leader>cT",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Buffer autoformat " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
      end,
      desc = "Toggle buffer autoformat",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        prettier = {
          prepend_args = { "--single-quote", "--jsx-single-quote" },
        },
        eslint_d = {
          -- Only run eslint_d if the project has an ESLint config
          condition = function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname == "" then
              return false
            end
            local root = vim.fs.find({
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
              "eslint.config.js",
              "eslint.config.mjs",
              "package.json",
            }, {
              path = bufname,
              upward = true,
            })[1]
            return root ~= nil
          end,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        graphql = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        go = { "goimports" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        css = { "prettier" },
        tailwindcss = { "prettier" },
        html = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 1000,
          lsp_format = "fallback",
        }
      end,
    })
  end,
}
