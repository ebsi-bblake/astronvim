---@type LazySpec
return {
  -- Mason setup for managing LSPs, formatters, and linters
  {
    "williamboman/mason.nvim",
    opts = function() require("mason").setup() end,
  },

  -- Setup mason-lspconfig for LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "cssls",
        "html",
        "jsonls",
        "vimls",
        "angularls",
        "bashls",
        "dockerls",
        "emmet_ls",
        "marksman",
        "sqlls",
        "tailwindcss",
        "yamlls",
      },
    },
  },

  -- Setup mason-null-ls to install formatters and linters
  {
    "williamboman/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "prettierd", "eslint_d", "stylua" }, -- Ensure these tools are installed
    },
  },
  -- Copilot for Neovim
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  -- LSP Configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local null_ls = require("null-ls")

      -- Setup null-ls for Prettier (formatting) and ESLint (linting)
      null_ls.setup({
        sources = {
          -- Prettier for formatting Vue, JavaScript, TypeScript, HTML, etc.
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "typescript", "vue", "html", "css", "json", "ts", "js" }, -- Ensure Vue is properly handled
            extra_args = { "--single-quote" },                                                    -- Force single quotes if needed
          }),

          -- ESLint for linting
          null_ls.builtins.diagnostics.eslint_d.with({
            filetypes = { "javascript", "typescript", "vue", "ts", "js" },
          }),
          null_ls.builtins.code_actions.eslint_d,

          -- Stylua for Lua formatting
          null_ls.builtins.formatting.stylua.with({
            filetypes = { "lua" },
          }),
        },
      })

      -- -- Disable formatting in TSServer to avoid conflicts with Prettier
      -- lspconfig.tsserver.setup({
      --   on_attach = function(client)
      --     client.server_capabilities.documentFormattingProvider = false -- Disable TSServer formatting
      --   end,
      -- })

      -- Disable formatting in ESLint to avoid conflicts
      lspconfig.eslint_d.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Disable ESLint formatting
        end,
      })

      -- Format on save using null-ls (Prettier and Stylua)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.ts", "*.vue", "*.json", "*.lua" }, -- Auto format for these file types
        callback = function()
          vim.lsp.buf.format({ async = true })                    -- Trigger formatting on save
        end,
      })

      -- Other LSP configurations (CSS, HTML, etc.)
      lspconfig.cssls.setup({})
      lspconfig.html.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.yamlls.setup({})
    end,
  },
}
