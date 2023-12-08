" Download plug.vim if it doesn't exist yet
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/.vimrc
\| endif

" Always use the system clipboard
set clipboard+=unnamedplus

call plug#begin("~/.vim/plugged")
Plug 'sheerun/vim-polyglot'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'jeffkreeftmeijer/vim-nightfall'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kaplanz/retrail.nvim'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
call plug#end()

colorscheme nightfly

" Formatting
set number
set tabstop=2
set shiftwidth=2
set expandtab

" Use <cr> to select the first completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

lua require'retrail'.setup {}
