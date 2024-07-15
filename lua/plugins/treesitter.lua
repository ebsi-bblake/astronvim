-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true,
    },
    ensure_installed = {
      "lua",
      "vim",
      "javascript",
      "python",
      "bash",
      "markdown",
    },
  },
}
