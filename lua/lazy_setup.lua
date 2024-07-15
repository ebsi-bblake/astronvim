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
  },
  { import = "community" },
  { import = "plugins" },
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
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
                stdin = true,
              }
            end,
          },
          typescript = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
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
