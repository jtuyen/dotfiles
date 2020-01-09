call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Vim Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"Vim Settings
set number relativenumber
set textwidth=150
set scrolloff=50

"FZF Settings
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :<C-u>FZF</CR>

"Custom Key Bindings
:nnoremap <C-j> :bprev<CR>
:nnoremap <C-k> :bnext<CR>
:nnoremap <C-w> :bd<CR>

call plug#end()
