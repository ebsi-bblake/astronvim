if true then return {} end
-- Other plugins...
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      shell = "powershell", -- Set the shell to Bash
    }
  end,
}
