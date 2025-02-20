---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true, -- Enable format on save
        allow_filetypes = {
          "javascript",
          "typescript",
          "vue",
          "json",
          "lua",
          "swift",
        },
        ignore_filetypes = {},
      },
      disabled = {
        "eslint_d", -- Ensure eslint_d does NOT format
      },
      timeout_ms = 10000,
    },
    servers = {
      "pyright", -- Python LSP
      "eslint_d", -- Fast ESLint alternative for diagnostics
      "prettierd", -- Prettier for formatting
      "sourcekit", -- Swift LSP
      "typescript-tools.nvim", -- TypeScript Tools for better performance
    },
    config = {
      sourcekit = {
        filetypes = { "swift" },
        on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = true end,
      },
      -- ESLint D setup for diagnostics only (no formatting)
      eslint_d = {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Disable formatting in ESLint D
        end,
      },
      -- ESLint D setup for diagnostics only (no formatting)
      eslint_d = {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Disable formatting in ESLint D
        end,
      },
      -- Prettierd setup for formatting on save
      null_ls = {
        sources = {
          require("null-ls").builtins.formatting.prettierd.with({
            filetypes = { "javascript", "typescript", "vue", "html", "css", "json", "js", "ts" }, -- Prettier formats these file types
          }),
        },
      },
      -- TypeScript Tools setup
      ["typescript-tools.nvim"] = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true -- Enable formatting
        end,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = { "add_missing_imports", "organize_imports" },
          tsserver_max_memory = "auto",
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
        },
      },
    },
    -- Set up synchronous format-on-save for Prettierd and TypeScript Tools
    mappings = {},
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        -- Create the group before clearing autocommands
        local augroup = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })

        -- Ensure only one format-on-save autocommand is created
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.swift",
          callback = function() vim.lsp.buf.format() end,
        })
        -- Create format-on-save autocommand for JavaScript/TypeScript/Vue
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          pattern = { "*.js", "*.ts", "*.vue", "*.json" }, -- Automatically format these file types
          callback = function()
            vim.lsp.buf.format({ async = false }) -- Trigger formatting synchronously
          end,
        })

        -- Optional: Set up key mappings for manual formatting
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          "<leader>f",
          "<cmd>lua vim.lsp.buf.format({ async = false })<CR>",
          { noremap = true, silent = true }
        )
      end
    end,
  },
}
