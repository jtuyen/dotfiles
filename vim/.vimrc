"Pathogen Settings
execute pathogen#infect()
filetype plugin indent on
syntax on

"Vim Settings
set number relativenumber
"filetype plugin indent on
set nu rnu
set textwidth=150

"Vimwiki Settings
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"syntax on
filetype plugin on
set nocompatible
let g:vimwiki_folding = 'manual'
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

"NERDTree Settings
"nmap <F6> :NERDTreeToggle<CR>
"let NERDTreeShowHidden=1

"FZF Settings
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :<C-u>FZF<CR>

"ALE Settings
"let g:ale_linters = {'python':['pylint']}
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"Instant Markdown Settings
"let g:instant_markdown_autostart = 0
"map <leader>md :InstantMarkdownPreview<CR>
"let g:instant_markdown_slow = 1

"Livedown.vim
let g:livedown_autorun = 0
let g:livedown_port = 8090
let g:livedown_browser = "google chrome"
map <leader>md :LivedownToggle<CR>

"Key Bindings
iab <expr> xdate strftime("%a, %d %b %Y %H:%M:%S %z")
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>
:nnoremap <space> i<space><esc>
:nmap <CR><CR> o<ESC>
:nmap <CR><CR> O<ESC>
:nnoremap <C-j> :bprev<CR>
:nnoremap <C-k> :bnext<CR>
:nnoremap <C-w> :w<ESC>:bd<CR>
