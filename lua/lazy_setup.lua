require("lazy").setup({
  -- AstroNvim setup
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
    lsp = {
      formatting = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "janBorowy/jirac.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "grapp-dev/nui-components.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function() require("blame").setup({}) end,
    opts = {
      blame_options = { "-w" },
    },
  },
  -- Import community and additional plugins
  { import = "community" },
  { import = "plugins" },

  -- Language Support with Volar and Prettierd
  {
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v1.x",
      dependencies = {
        "neovim/nvim-lspconfig", -- Required
        "williamboman/mason.nvim", -- Optional
        "williamboman/mason-lspconfig.nvim", -- Optional

        -- Autocompletion
        "hrsh7th/nvim-cmp", -- Required
        "hrsh7th/cmp-nvim-lsp", -- Required
        "hrsh7th/cmp-buffer", -- Optional
        "hrsh7th/cmp-path", -- Optional
        "saadparwaiz1/cmp_luasnip", -- Optional
        "L3MON4D3/LuaSnip", -- Required
        "rafamadriz/friendly-snippets", -- Optional
      },
    },

    -- Add Vue syntax highlighting and file detection
    {
      "posva/vim-vue", -- Vue plugin for Vue syntax
      event = "BufReadPost",
    },

    -- Add Volar LSP support for Vue 3
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        -- Setup Mason for managing LSPs and other tools
        require("mason").setup()

        -- Volar setup to handle Vue, JavaScript, and TypeScript files
        -- require("lspconfig").volar.setup({
        --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        --   init_options = {
        --     vue = {
        --       hybridMode = false, -- Disable hybrid mode for Volar
        --     },
        --   },
        --   on_attach = function(client)
        --     client.server_capabilities.documentFormattingProvider = false -- Disable formatting in Volar to avoid conflict with Prettierd
        --   end,
        -- })

        -- Prettierd setup for formatting Vue, JS, and TS files
        -- require("null-ls").setup({
        --   sources = {
        --     require("null-ls").builtins.formatting.prettierd.with({
        --       filetypes = { "javascript", "typescript", "vue", "html", "css", "json" },
        --     }),
        --   },
        --   on_attach = function(client)
        --     if client.supports_method("textDocument/formatting") then
        --       -- Ensure format-on-save is triggered
        --       -- vim.api.nvim_create_autocmd("BufWritePre", {
        --       --   desc = "Auto format before save",
        --       --   pattern = { "*.js", "*.ts", "*.vue", "*.json" }, -- Auto format these file types
        --       --   callback = function()
        --       --     vim.lsp.buf.format({ async = false }) -- Synchronous formatting to ensure it completes before saving
        --       --   end,
        --       -- })
        --     end
        --   end,
        -- })
      end,
    },

    -- nvim-cmp for autocompletion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
        "hrsh7th/cmp-buffer", -- Buffer completions
        "hrsh7th/cmp-path", -- Path completions
        "hrsh7th/cmp-cmdline", -- Command line completions
        "L3MON4D3/LuaSnip", -- Snippet engine
        "saadparwaiz1/cmp_luasnip", -- Snippet completions
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args) require("luasnip").lsp_expand(args.body) end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "luasnip" },
          },
        })
      end,
    },
  },

  -- Lazygit for Git integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function() require("telescope").load_extension("lazygit") end,
  },

  -- Nord colorscheme
  {
    "arcticicestudio/nord-vim",
    config = function()
      -- Enable the Nord theme
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true

      -- Enable termguicolors for true color support
      vim.opt.termguicolors = true

      -- Apply the Nord theme
      vim.cmd([[colorscheme nord]])

      -- Customize Visual mode highlighting
      vim.cmd([[highlight Visual ctermfg=0 ctermbg=82 guifg=#000000 guibg=#00FF00]])
      vim.cmd([[highlight TabLineSel guibg=#00FF00 guifg=#000000]])
    end,
  },
}, {
  -- Lazy.nvim configuration options
  install = { colorscheme = { "nord" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
