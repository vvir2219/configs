call plug#begin()

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'
 
set completeopt=menu,menuone,noselect

" looks

Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'

" tpope

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-dispatch' " not needed for now, conflict with my m normal mapping(next match)

" other

Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0

Plug 'romgrk/replace.vim'

noremap R <Plug>ReplaceOperator
vnoremap R <Plug>ReplaceOperator

Plug 'junegunn/gv.vim'

Plug 'preservim/nerdcommenter'

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1

Plug 'jeetsukumaran/vim-indentwise'

Plug 'justinmk/vim-sneak'

let g:sneak#s_next = 1

Plug 'chaoren/vim-wordmotion'

let g:wordmotion_prefix = "<leader>"

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"app/uploaders/handicapfile_uploader.rb"

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>

Plug 'jremmen/vim-ripgrep'

Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'

let g:asterisk#keeppos = 1
map *  <Plug>(asterisk-z*)
map g* <Plug>(asterisk-gz*)
map #  <Plug>(asterisk-z#)
map g# <Plug>(asterisk-gz#)

Plug 'rhysd/devdocs.vim'

nmap K <Plug>(devdocs-under-cursor)
let g:devdocs_filetype_map = {
    \   'ruby': 'rails',
    \   'javascript.jsx': 'react',
    \   'javascript.test': 'chai',
    \ }

Plug 'andymass/vim-matchup'

Plug 'AndrewRadev/tagalong.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'camspiers/lens.vim'

let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
" let g:lens#height_resize_max = 120
" let g:lens#width_resize_max = 150

call plug#end()

lua << EOF

require("mason").setup()

local lsp = require('lsp-zero')

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})
lsp.setup()

vim.diagnostic.disable()

EOF


" system variables
let mapleader=','
let maplocalleader=","

" syntax and autocompletion

syntax on
filetype plugin indent on
" set omnifunc=syntaxcomplete#Complete

" basic usage

set mouse=a
set encoding=utf-8
set incsearch
set hlsearch
set ignorecase
set smartcase

set wildmenu
set wildchar=<tab>
set wildmode=list:longest

set backspace=indent,eol,start

" dvorak remappings

noremap h j
noremap t k
noremap n l

noremap ; :
noremap : ;

noremap m n
noremap M N
" noremap <C-m> K

" some benefits
no - $
no _ ^
no N <C-w><C-w>
no H 8<Down>
no T 8<Up>

" remaps

nnoremap ; :
nnoremap : ;

" looks

set ai
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
autocmd FileType javascript,javascriptreact,coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

set textwidth=100
set ruler
" set number
set scrolloff=4
set nowrap
set sidescrolloff=8
set lazyredraw

set t_Co=256   " This is may or may not needed.

set background=dark
" colorscheme PaperColor
colorscheme gruvbox

set cole=2
hi clear Conceal

" misc

nnoremap <leader>yfl :let @+=expand("%") . ':' . line('.')<CR>
nnoremap <C-c> <C-^> 
" nnoremap <Leader>b :buffers<CR>:buffer<Space>
function! s:MyBufList()
  set nomore
  let buf_count = bufnr("$")
  for i in range(1, buf_count)
    if getbufvar(l:i, '&buflisted') > 0
      let path = bufname(i)
      let filename = fnamemodify(path, ":t")
      let folder = fnamemodify(path, ":h")
      echo filename . "\t(" . folder . ")"
    endif
  endfor
  set more
endfunction

command! MBL call s:MyBufList()

nnoremap <Leader>b :MBL<CR>:b<Space>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

noremap <leader>cf :call CreateFile(expand("<cfile>"))<CR>
function! CreateFile(tfilename)

    " complete filepath from the file where this is called
    let newfilepath=expand('%:p:h') .'/'. expand(a:tfilename)

    if filereadable(newfilepath)
       echo "File already exists"
       :norm gf
    else
        :execute "!touch ". expand(newfilepath)
        echom "File created: ". expand(newfilepath)
        :norm gf
    endif

endfunction

nnoremap <leader>d :w !diff % -<cr>
