call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
" Plug 'sainnhe/gruvbox-material'
" Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'tpope/vim-commentary'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

set termguicolors
set background=dark
" Settings for gruvbox-material
" let g:gruvbox_material_bold=1
" let g:gruvbox_material_italic=1
" let g:gruvbox_material_diagnostic_line_highlight=1

" Settings for gruvbox
" let g:gruvbox_contrast_dark="soft"
" let g:gruvbox_transparent_bg=1

" Settings for nord
let g:nord_cursor_line_number_background=1
let g:nord_italic=1
let g:nord_italic_comments=1
colorscheme nord

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd colorscheme * hi Normal guibg=NONE ctermbg=NONE

" let g:airline_theme='gruvbox'
" let g:airline_theme='gruvbox_material'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'

syntax on
filetype plugin indent on
set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if bufname('%') =~# '^NERD_tree_' | set nonumber | else | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter	 * set norelativenumber
augroup END

set cursorline

function! DeleteTrailingWhitespace()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction

autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
autocmd BufWritePre *.{py,tex,cpp,c,hpp,h,js,html,css,ts,vim,txt,bib} call DeleteTrailingWhitespace()

let mapleader=','
nnoremap <leader><space> :nohlsearch<cr>

nmap <leader>ge <Plug>(coc-declaration)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implemetation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next='<tab>'

inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

autocmd FileType json syntax match Comment +\/\/.\+$+

let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-eslint',
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-texlab',
    \ 'coc-tsserver',
    \ 'coc-snippets'
    \]
