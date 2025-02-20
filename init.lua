-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.

-- Bootstrap lazy.nvim
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Validate that lazy.nvim is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {}
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Load Lazy.nvim setup
require("lazy_setup")

-- Load additional custom configurations
require("polish")

-- Auto-command to run isort and black on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end,
})

-- Example key mapping (complete the mapping here)
vim.api.nvim_set_keymap("n", "<leader>r", '<cmd>lua require("spectre").open()<CR>', { noremap = true, silent = true })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- Increase Node.js memory limit for LSP servers
vim.env.NODE_OPTIONS = "--max-old-space-size=4096"
