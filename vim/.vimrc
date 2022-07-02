call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

"Vim Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"Vim Settings
set number relativenumber
set textwidth=150
set scrolloff=50
let mapleader="^B"

"FZF Settings
set rtp+=/usr/local/opt/fzf

"Vim Keymaps
nmap <Leader>g :term<CR>
nmap <Leader>h :bprev<CR>
nmap <Leader>l :bnext<CR>
nmap <Leader>a :Explore<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>x :bd<CR>
nmap <Leader>w <C-w>z<CR>
nmap <Leader>r :History:<CR>

call plug#end()

