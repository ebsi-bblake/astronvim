-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true, -- Enable syntax highlighting
    },
    ensure_installed = {
      "lua",
      "vim",
      "javascript",
      "typescript",
      "python",
      "bash",
      "markdown",
      "c_sharp",
      "jsonc",
    },
    incremental_selection = {
      enable = true, -- Enable incremental selection
      keymaps = {
        init_selection = "gnn", -- Start selection with `gnn`
        node_incremental = "grn", -- Increment to the next node with `grn`
        scope_incremental = "grc", -- Increment to the next scope with `grc`
        node_decremental = "grm", -- Decrement selection with `grm`
      },
    },
    textobjects = {
      select = {
        enable = true, -- Enable text objects
        lookahead = true, -- Jump forward to matching text object
        keymaps = {
          ["af"] = "@function.outer", -- Select around a function
          ["if"] = "@function.inner", -- Select inside a function
          ["ac"] = "@class.outer", -- Select around a class
          ["ic"] = "@class.inner", -- Select inside a class
        },
      },
      move = {
        enable = true, -- Enable movement between text objects
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer", -- Go to next function start
          ["]c"] = "@class.outer", -- Go to next class start
        },
        goto_previous_start = {
          ["[m"] = "@function.outer", -- Go to previous function start
          ["[c"] = "@class.outer", -- Go to previous class start
        },
      },
    },
  },
}
