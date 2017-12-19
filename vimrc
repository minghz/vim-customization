execute pathogen#infect()
syntax on
filetype plugin indent on

" NERDTree open shortcut
map <C-p> :NERDTreeToggle<CR>

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['scss$']

" convert tabs to spaces and tabspaces to 2
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" intuitive window splitting
set splitbelow
set splitright

" show line numbers
set number

" background color warning for long lines
set colorcolumn=80

" allow mouse use
set mouse=a

" use solarized colorscheme
syntax enable
set background=dark
colorscheme solarized

" use solarized airline theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" copy and paste in visual mode using standard ctrl-c ctrl-v keys
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
