"Pathogen Settings
execute pathogen#infect()
filetype plugin indent on
syntax on

"Vim Settings
set number relativenumber
"filetype plugin indent on
set nu rnu
set textwidth=150
set scrolloff=50

"Vimwiki Settings
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"syntax on
filetype plugin on
set nocompatible
let g:vimwiki_folding = 'expr'
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

"FZF Settings
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :<C-u>FZF<CR>

"vim-grip
let g:grip_default_map = 0
:nnoremap <leader>md :GripStart<CR>
:nnoremap <leader>mx :GripClean!<CR>

"ALE Settings
"let g:ale_linters = {'python':['pylint']}
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"vim-buftabline
set hidden

"Key Bindings
iab <expr> xdate strftime("%a, %d %b %Y %H:%M:%S %z")
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <CR>=strftime("%c")<CR>
:nnoremap <SPACE> i<SPACE><ESC>
:nmap <CR><CR> o<ESC>
:nmap <CR><CR> O<ESC>
:nnoremap <C-j> :bprev<CR>
:nnoremap <C-k> :bnext<CR>
:nnoremap <C-w> :w<CR>:bd<CR>
:nnoremap <C-e> :bd<CR>
