-- Load Plugins
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- LSP Configurations
  use 'neovim/nvim-lspconfig' 

  -- Completion Engine
  use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      requires = {
          'ms-jpq/coq.artifacts',
          branch = 'artifacts'
      }
  }

  -- File Explorer
  use {
      'ms-jpq/chadtree',
      branch = 'chad'
  }
  
  -- Base16 Themes
  use 'chriskempson/base16-vim'

  -- Git Signs
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
        {'nvim-lua/popup.nvim'}, 
        {'nvim-lua/plenary.nvim'},
        {'nvim-treesitter/nvim-treesitter'}
    }
  }
  
  use 'nvim-lualine/lualine.nvim' -- Statusline
  
  use {
    'robaire/nvim-tmux-navigator', -- Tmux navigator shortcuts
    branch = 'dev'
  }

  use 'simrat39/rust-tools.nvim' -- Rust LSP features
end)


-- Configure Language Servers
local lsp = require('lspconfig')
lsp.cmake.setup{}
lsp.clangd.setup{}
lsp.pyright.setup{}
lsp.html.setup{cmd = { "html-languageserver", "--stdio" }}
lsp.tsserver.setup{}
lsp.rust_analyzer.setup{}
lsp.hls.setup{}

-- Configure Rust Tools
require('rust-tools').setup{}

require('gitsigns').setup{}
require('nvim-tmux-navigator').setup{}

-- Statusline Configuration
require('lualine').setup{
  options = {
    theme = 'gruvbox',
    icons_enabled = false
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
vim.o.undofile = true

-- Context Specific Options
vim.wo.number = true
vim.wo.wrap = false

-- Undo some conflicting keymappings from Coq
vim.g.coq_settings = {
    keymap = {
        jump_to_mark = '',
        bigger_preview = ''
    }
}

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

-- Use escape to enter normal mode from terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-N>', {noremap = true, silent = true})

-- Provide window navigation from terminal mode without switching modes
vim.api.nvim_set_keymap('t', '<C-J>', '<C-\\><C-N><C-W><C-J>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-K>', '<C-\\><C-N><C-W><C-K>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-L>', '<C-\\><C-N><C-W><C-L>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-H>', '<C-\\><C-N><C-W><C-H>', {noremap = true, silent = true})

-- Enable completion in all buffers
vim.api.nvim_command('au BufEnter * COQnow -s')
vim.api.nvim_command('set completeopt=menuone,noinsert,noselect')
vim.api.nvim_command('set shortmess+=c')
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', {noremap = true, expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-n>" : "<S-Tab>"', {noremap = true, expr = true})

