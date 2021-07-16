" Package Management via Vim Plug
call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'liuchengxu/space-vim-dark'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'rust-lang/rust.vim'
	Plug 'vim-syntastic/syntastic'
	Plug 'tpope/vim-fugitive'
call plug#end()

" Indentation
set tabstop=4
set shiftwidth=4
set noexpandtab

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERD Tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Style & Theming
colorscheme space-vim-dark
hi Comment cterm=italic
hi LineNr ctermbg=NONE guibg=NONE
let g:airline_theme='simple'
syntax enable
filetype plugin indent on
