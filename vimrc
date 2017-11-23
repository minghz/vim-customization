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

" allow mouse use
set mouse=a
