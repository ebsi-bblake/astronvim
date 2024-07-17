require("lazy").setup({
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
  { import = "community" },
  { import = "plugins" },

  -- Language Support
  -- Added this plugin.
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "hrsh7th/cmp-buffer" }, -- Optional
      { "hrsh7th/cmp-path" }, -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" }, -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" }, -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional
    },
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup {
        logging = false,
        filetype = {
          javascript = {
            function()
              return {
                exe = "prettier",
                args = {
                  "--config-precedence",
                  "prefer-file",
                  "--single-quote",
                  "--no-bracket-spacing",
                  "--prose-wrap",
                  "always",
                  "--arrow-parens",
                  "avoid",
                  "--trailing-comma",
                  "all",
                  "--no-semi",
                  "--end-of-line",
                  "lf",
                  "--stdin-filepath",
                  vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
          typescript = {
            function()
              return {
                exe = "prettier",
                args = {
                  "--config-precedence",
                  "prefer-file",
                  "--single-quote",
                  "--no-bracket-spacing",
                  "--prose-wrap",
                  "always",
                  "--arrow-parens",
                  "avoid",
                  "--trailing-comma",
                  "all",
                  "--no-semi",
                  "--end-of-line",
                  "lf",
                  "--stdin-filepath",
                  vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
                },
                stdin = true,
              }
            end,
          },
          python = {
            function()
              return {
                exe = "black",
                args = { "-" },
                stdin = true,
              }
            end,
          },
        },
      }
      local prettier = function()
        local view = vim.fn.winsaveview()
        vim.cmd("silent %!prettier --stdin-filepath " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) .. " --write")
        vim.fn.winrestview(view)
      end

      -- Create an augroup for formatting
      local format_group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
      -- Create an autocmd to format with Prettier on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        pattern = "*.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.md", -- Add your file types
        callback = prettier,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function() require("telescope").load_extension "lazygit" end,
  },
  {
    "kelly-lin/telescope-ag",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope_ag = require "telescope-ag"
      telescope_ag.setup {
        cmd = telescope_ag.cmds.rg, -- defaults to telescope_ag.cmds.ag
      }
    end,
  },
  -- Add Nord colorscheme
  {
    "arcticicestudio/nord-vim",
    config = function()
      -- Additional settings for the Nord theme
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true

      -- Enable termguicolors for true color support
      vim.opt.termguicolors = true

      -- Apply the Nord theme
      vim.cmd [[colorscheme nord]]
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
