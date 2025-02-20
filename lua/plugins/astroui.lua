-- AstroUI provides the basis for configuring the AstroNvim User Interface

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- You can change colorscheme
    -- colorscheme = "nord",
    highlights = {
      init = {
        -- Override highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = {
        -- A table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    icons = {
      -- Configure the loading of the LSP in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
