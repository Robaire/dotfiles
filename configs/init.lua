-- Load Plugins
require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use 'neovim/nvim-lspconfig' -- LSP Configurations
	use 'nvim-lua/completion-nvim' -- Completion engine using LSP

	use 'onsails/lspkind-nvim' -- LSP Pictograms
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua' -- File explorer

	-- Fuzzy Finder
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	use 'hoob3rt/lualine.nvim' -- Statusline

 	use {
 	  'robaire/nvim-tmux-navigator', -- Tmux navigator shortcuts
 	  branch = 'dev'
  	}
end)

-- Configure Language Servers
local lsp = require('lspconfig')
lsp.cmake.setup{}
lsp.clangd.setup{}
lsp.rls.setup{}
lsp.pyright.setup{}
lsp.html.setup{}

-- Statusline Configuration
require('lualine').setup{
  options = {
    theme = 'gruvbox',
    icons_enabled = true
  }
}

require('nvim-tmux-navigator').setup{}

-- General Options
vim.o.compatible = false -- Disable compatiblity mode
vim.o.number = true -- Show line numbers
vim.o.cursorline = true -- Highlight the cursor line
vim.o.clipboard = 'unnamedplus' -- Use the system clipboard
vim.o.updatetime = 300 -- Increase update rate
vim.o.wrap = false -- Disable line wrapping
vim.o.tabstop = 4 -- Tab width
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.mouse = 'a' -- Enable mouse all the time
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.backup = false
-- vim.o.undodir = '~/.cache/nvim/undodir'
vim.o.undofile = true

-- Context Specific Options
vim.wo.number = true
vim.wo.wrap = false

-- Enable spell checking and wrapping in certain files
vim.api.nvim_command([[
augroup SetSpell
autocmd BufRead,BufNewFile *.md setlocal spell wrap linebreak textwidth=0
autocmd BufRead,BufNewFile *.txt setlocal spell wrap linebreak textwidth=0
augroup END
]])

-- Disable line numbers in terminal
vim.api.nvim_command('au TermOpen * setlocal nonumber norelativenumber')

-- If starting without file arguments open NvimTree
vim.api.nvim_command([[
augroup AutoTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NvimTreeOpen | endif
augroup END
]])
