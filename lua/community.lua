--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Import the AstroNvim community modules
  "AstroNvim/astrocommunity",

  -- Example of importing a specific community pack
  -- { import = "astrocommunity.pack.lua" },

  -- User-specific plugins
  {
    "mg979/vim-visual-multi", -- Multi-cursor plugin for Vim
    branch = "master",
  },
  {
    {
      "Isrothy/neominimap.nvim",
      config = function()
        vim.g.neominimap_width = 10     -- Set minimap width
        vim.g.neominimap_auto_start = 1 -- Automatically start the minimap on launch
      end,
    },
  },
  -- Additional user plugins or overrides can be added here
}
