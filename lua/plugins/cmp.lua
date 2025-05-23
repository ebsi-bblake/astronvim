-- Configuration for nvim-cmp (completion)

local cmp = require "cmp"
---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
  },
  config = function()
    cmp.setup {
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
    }
  end,
}
