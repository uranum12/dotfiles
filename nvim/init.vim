let g:python3_host_prog = '~/.neovim/provider/python/venv/bin/python'
let g:node_host_prog = '~/.neovim/provider/nodejs/node_modules/neovim/bin/cli.js'
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

set scrolloff=20
set ignorecase
set hidden
set number
set relativenumber
set termguicolors
set undofile
set undodir=~/.neovim/undo

nnoremap <silent> <Esc><Esc> <cmd>noh<CR>

nnoremap <silent> <Leader>a <cmd>vs<CR>
nnoremap <silent> <Leader>s <cmd>sp<CR>

let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()

" plugin manager
call jetpack#add('tani/vim-jetpack', {'opt': 1})

" library
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('kkharji/sqlite.lua')

" filetype
call jetpack#add('nathom/filetype.nvim')

" icons
call jetpack#add('kyazdani42/nvim-web-devicons')

" colorscheme
call jetpack#add('navarasu/onedark.nvim')

" statusline
call jetpack#add('nvim-lualine/lualine.nvim')
call jetpack#add('SmiteshP/nvim-navic')

" bufferline
call jetpack#add('akinsho/bufferline.nvim')

" scrollbar
call jetpack#add('petertriho/nvim-scrollbar')
call jetpack#add('kevinhwang91/nvim-hlslens')

" dashboard
call jetpack#add('goolord/alpha-nvim')

" treesitter
call jetpack#add('nvim-treesitter/nvim-treesitter')
call jetpack#add('nvim-treesitter/nvim-treesitter-context')
call jetpack#add('haringsrob/nvim_context_vt')
call jetpack#add('m-demare/hlargs.nvim')
call jetpack#add('p00f/nvim-ts-rainbow')
call jetpack#add('JoosepAlviste/nvim-ts-context-commentstring')

" language server protocol
call jetpack#add('neovim/nvim-lspconfig')
call jetpack#add('williamboman/mason.nvim')
call jetpack#add('williamboman/mason-lspconfig.nvim')
call jetpack#add('j-hui/fidget.nvim')
call jetpack#add('folke/lsp-colors.nvim')
call jetpack#add('glepnir/lspsaga.nvim')

" auto complement
call jetpack#add('hrsh7th/nvim-cmp')
call jetpack#add('hrsh7th/cmp-nvim-lsp')
call jetpack#add('hrsh7th/cmp-path')
call jetpack#add('hrsh7th/cmp-cmdline')
call jetpack#add('hrsh7th/cmp-buffer')
call jetpack#add('saadparwaiz1/cmp_luasnip')
call jetpack#add('onsails/lspkind.nvim')

" snippet
call jetpack#add('L3MON4D3/LuaSnip')

" fuzzy finder
call jetpack#add('nvim-telescope/telescope.nvim', {'branch': '0.1.x'})
call jetpack#add('nvim-telescope/telescope-file-browser.nvim')
call jetpack#add('nvim-telescope/telescope-frecency.nvim')
call jetpack#add('AckslD/nvim-neoclip.lua')

" terminal
call jetpack#add('akinsho/toggleterm.nvim')

" comment
call jetpack#add('tpope/vim-commentary')

" editorconfig
call jetpack#add('editorconfig/editorconfig-vim')

" number
call jetpack#add('myusuf3/numbers.vim')

" auto pairs
call jetpack#add('windwp/nvim-autopairs')

" highlight
call jetpack#add('RRethy/vim-illuminate')

" window
call jetpack#add('tkmpypy/chowcho.nvim')

" undo
call jetpack#add('mbbill/undotree')

" git
call jetpack#add('lewis6991/gitsigns.nvim')

call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

let g:numbers_exclude = ['alpha', 'toggleterm']

lua<<==========
require("filetype").setup({
  overrides = {
    extensions = {
      h = "c",
    }
  }
})

require('onedark').setup({
  style = "darker",
  transparent = true
})
require('onedark').load()

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    }
  }
})

require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI"
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

require("chowcho").setup({
  icon_enabled = true,
  border_style = "rounded",
})

require('config.nvim-treesitter')
require('config.nvim-lspconfig')
require('config.nvim-cmp')
require('config.telescope')
require('config.alpha')
require('config.lualine')
require('config.toggleterm')

require('bufferline').setup()
require('fidget').setup()
require('scrollbar').setup()
require('scrollbar.handlers.search').setup()
require('nvim-autopairs').setup()
require('gitsigns').setup()

vim.api.nvim_set_keymap("n", "<Leader><Leader>", "<cmd>Chowcho<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>u", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", { noremap = true, silent = true })

require('lspsaga').init_lsp_saga()
vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "<Space>k", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<Space>g", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>", { silent = true })
==========

