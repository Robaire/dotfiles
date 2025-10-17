-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup Plugins
require("lazy").setup({

  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig", -- LSP Configurations
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  "chriskempson/base16-vim", -- Base16 Themes
  "nvim-lualine/lualine.nvim", -- Status Line
  "lewis6991/gitsigns.nvim", -- Git Integration
  {"ms-jpq/coq_nvim",
    branch = "coq",
	dependencies = {"ms-jpq/coq.artifacts", branch = "artifacts"}
  }
})

-- Plugin Specific Setup
require("lualine").setup{
  options = {
    theme = 'gruvbox',
    icons_enabled = false
    }
}

-- General Options
vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
-- vim.o.tabstop = 4

-- Enable completion in all buffers
vim.api.nvim_command('au BufEnter * COQnow -s')

-- Enable text wrapping for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
  end,
})
