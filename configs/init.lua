-- Load Plugins
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Plugin Manager
  use 'neovim/nvim-lspconfig' -- LSP Configurations
  use {
      'ms-jpq/coq_nvim', -- LSP Completion Engine
      branch = 'coq',
      requires = {
          'ms-jpq/coq.artifacts',
          branch = 'artifacts',
      }
  }
  use 'chriskempson/base16-vim' -- Base16 Theme
  use 'tpope/vim-vinegar' -- Directory Browser using netrw
  use {
      'lewis6991/gitsigns.nvim', -- Git decorations
      requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy Finder
    requires = {{'nvim-treesitter/nvim-treesitter'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'hoob3rt/lualine.nvim' -- Statusline
  use 'robaire/nvim-tmux-navigator' -- Tmux navigator shortcuts
end)

-- Configure Language Servers
local lsp = require('lspconfig')
lsp.cmake.setup{}
lsp.clangd.setup{}
lsp.rls.setup{}
lsp.pyright.setup{}
-- lsp.html.setup{}

require('nvim-tmux-navigator').setup{}
require('gitsigns').setup{}

-- Statusline Configuration
require('lualine').setup{
  options = {
    theme = 'gruvbox',
    icons_enabled = true
  }
}

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

vim.api.nvim_command('filetype plugin on')
vim.api.nvim_command('let g:netrw_liststyle = 3')

-- Setting Theme
vim.api.nvim_command([[
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
]])

-- Enable spell checking and wrapping in certain files
vim.api.nvim_command([[
augroup SetSpell
autocmd BufRead,BufNewFile *.md setlocal spell wrap linebreak textwidth=0
autocmd BufRead,BufNewFile *.txt setlocal spell wrap linebreak textwidth=0
augroup END
]])

vim.api.nvim_command([[
highlight clear SpellBad
highlight SpellBad cterm=undercurl ctermfg=3
]])

-- Disable line numbers in terminal
vim.api.nvim_command('au TermOpen * setlocal nonumber norelativenumber')

-- Enable completion in all buffers
vim.api.nvim_command('au BufEnter * COQnow -s')
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', {noremap = true, expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-n>" : "<S-Tab>"', {noremap = true, expr = true})
vim.api.nvim_command('set completeopt=menuone,noinsert,noselect')
vim.api.nvim_command('set shortmess+=c')
