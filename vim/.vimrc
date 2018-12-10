"Pathogen Settings
execute pathogen#infect()
filetype plugin indent on
syntax on

"Vim Settings
set number relativenumber
"filetype plugin indent on
set nu rnu
set textwidth=100

"Vimwiki Settings
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]
"syntax on
filetype plugin on
set nocompatible

"NERDTree Settings
"nmap <F6> :NERDTreeToggle<CR>
"let NERDTreeShowHidden=1

"FZF Settings
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :<C-u>FZF<CR>

"ALE Settings"
"let g:ale_linters = {'python':['pylint']}
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"Key Bindings
iab <expr> xdate strftime("%a, %d %b %Y %H:%M:%S %z")
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>
