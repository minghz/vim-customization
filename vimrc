execute pathogen#infect()
syntax on
filetype plugin indent on

" NERDTree open shortcut
map <C-p> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" Neomake configuration - lynt and syntax checker
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elseif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif

" Fuzzy file search in command line
" fzf Installed with Homebrew
set rtp+=/usr/local/opt/fzf

" convert tabs to spaces and tabspaces to 2
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" intuitive window splitting
set splitbelow
set splitright

" set larger preview window
set previewheight=30

" show line numbers
set number

" put tmp files elsewhere
set backupdir=~/.vim/backup//
set backupcopy=yes " make a copy of the file and overwrite the original one
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" background color warning for long lines
set colorcolumn=80

" allow mouse use
set mouse=a

" no wrappiing of lines
set nowrap

" font size
"set guifont=Menlo\ Regular:h12
set guifont=Hack\ Regular:h12

" lightline vim plugin
set laststatus=2
set noshowmode
let g:customLightlineConfig = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath' ] ]
      \}
      \}

"change colorscheme
nnoremap <leader>1 :call SetColorTwoFirewatch()<CR>
function SetColorTwoFirewatch()
  colorscheme two-firewatch
  set background=dark
  let g:customLightlineConfig.colorscheme = 'one'
  let g:lightline = g:customLightlineConfig
  call lightline#enable()
endfunction

nnoremap <leader>2 :call SetColorTwoFirewatchLight()<CR>
function SetColorTwoFirewatchLight()
  colorscheme two-firewatch
  set background=light
  let g:customLightlineConfig.colorscheme = 'solarized'
  let g:lightline = g:customLightlineConfig
  call lightline#enable()
endfunction

nnoremap <leader>3 :call SetColorDogrun()<CR>
function SetColorDogrun()
  colorscheme dogrun
  set background=dark
  let g:customLightlineConfig.colorscheme = 'dogrun'
  let g:lightline = g:customLightlineConfig
  call lightline#enable()
endfunction

nnoremap <leader>4 :call SetColorAfterglow()<CR>
function SetColorAfterglow()
  colorscheme afterglow
  set background=dark
  let g:customLightlineConfig.colorscheme = 'powerlineish'
  let g:lightline = g:customLightlineConfig
  call lightline#enable()
endfunction

" default colorschemes
syntax enable
set termguicolors " use truecolors
call SetColorTwoFirewatch()

" set text highlight on searched text
set hlsearch

" copy current file path
nmap cp :let @" = expand("%")<cr>:let @+ = expand("%")<cr>

" copy and paste in visual mode using standard ctrl-c ctrl-v keys
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" remove search highlight
nmap <leader>c :noh<CR>

" For better git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" Enable neovim colorizer
" It highlights color codes with the respective color equivalent
" See - https://github.com/norcalli/nvim-colorizer.lua
lua require'colorizer'.setup()

" Escape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> <Leader>h :Entities 0<CR>
noremap <silent> <Leader>H :Entities 1<CR>

" coc autofill configs
source ~/.vim_coc_config
