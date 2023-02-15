"""""""""""
" Plugins "
"""""""""""

" Install vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins managed by vim-plug.

" Specify a directory for plugins.
call plug#begin('~/.vim/plugged')

" Status line.
Plug 'itchyny/lightline.vim'

" Themes.
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'

" Show VCS diff.
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" FZF.
if has("gui_macvim")
    " Mac only (assuming only MacVim is used on Mac).
    Plug '/usr/local/opt/fzf'
else
    Plug '/usr/bin/fzf'
endif

Plug 'junegunn/fzf.vim'

" File explorer.
" On-demand loading.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Better syntax highlighting.
Plug 'sheerun/vim-polyglot'

" Support to edit fish scripts.
Plug 'dag/vim-fish'

" Some useful bracket key mapping.
" Like [n and ]n to move between git conflict marker.
Plug 'tpope/vim-unimpaired'

" Initialize plugin system.
call plug#end()

"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""

" Lightline.
if !has('gui_running')
    set t_Co=256
endif

let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'readonly': 'LightlineReadonly',
            \   'fugitive': 'LightlineFugitive',
            \   'cocstatus': 'coc#status'
            \ },
            \ }
" Custom separator.
            " 'separator': { 'left': '', 'right': '' },
            " 'subseparator': { 'left': '', 'right': '' }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Have to specify for fish vim (even though it's set on config.fish).
let $FZF_DEFAULT_COMMAND = "find ."

" signify
" default updatetime 4000ms is not good for async update
set updatetime=100

" Open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vim-polyglot
" Disable conceal (changing ',' into vertical lines)
" https://github.com/chrisbra/csv.vim#concealing
let g:csv_no_conceal = 1

""""""""""""""""""
" Plugin Rebinds "
""""""""""""""""""

" FZF
" Map fzf to ctrl-p (! to start in fullscreen.
nnoremap <silent> <C-p> :FZF!<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>

""""""""""""
" Settings "
""""""""""""

" Copied from
" https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim

" Turns on filetype detection, plugin, indent on.
filetype plugin indent on

" Show existing tab with 4 spaces width.
set tabstop=4

" When indenting with '>', use 4 spaces width.
set shiftwidth=4

" On pressing tab, insert 4 spaces.
set expandtab

" 2 indentation on HTML.
"autocmd FileType html setlocal shiftwidth=2 tabstop=2

syntax on

" Shows row and col numbers.
set ruler

" Shows vertical line.
set colorcolumn=100

" Shows relative line numbers.
set number
set relativenumber

" Word wrap.
set linebreak

" Highlight current line.
set cursorline

" Search as characters are entered.
set incsearch

" Highlight matches.
set hlsearch

" Show the command typed so far in bottom right corner.
set showcmd

" No automatic newline at end of file.
set nofixendofline

" Statusline appears all the time.
set laststatus=2

" No need to show '--INSERT--' on the last line
" because it is displayed in the statusline.
set noshowmode

" Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

"Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" No delay.
set ttimeoutlen=0

" Mouse support
set mouse=a

" Open new split below or to the right of the current pane.
set splitbelow splitright

" True colors
" https://github.com/tmux/tmux/issues/1246#issue-292083184
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Colorscheme
set background=dark
colorscheme onedark

" Removes pipe | separator from vertical splits.
" Note the space at the end.
set fillchars+=vert:\

if has ('macunix')
    " Mac

    " Use system clipboard.
    set clipboard=unnamed

    if has("gui_running")
        " GUI MacVim only.

        set transparency=5
        set macligatures

        " Remove scrollbar. See :help guioptions
        set guioptions-=r
    endif

else
    " Linux.

    set clipboard=unnamedplus

    " Source if exists.
    " https://stackoverflow.com/a/3098685
    if filereadable("/usr/share/doc/fzf/examples/fzf.vim")
        source /usr/share/doc/fzf/examples/fzf.vim
    endif
endif

set guifont=Fira\ Code:h14

" Fix vim background color issue.
" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
if &term == 'xterm-kitty'
    let &t_ut=''
endif

"if &diff
"    " Ignore whitespace in vimdiff
"    set diffopt+=iwhite
"endif

"""""""""""
" Rebinds "
"""""""""""

" Remap splits navigation to just ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use ESC to exit insert mode in :term
tnoremap <Esc> <C-\><C-n>

" https://vim.fandom.com/wiki/Easier_buffer_switching
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" https://stackoverflow.com/a/19877212
" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
