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

" Completion.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" LaTeX.
Plug 'lervag/vimtex'

" Support to edit fish scripts.
Plug 'dag/vim-fish'

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
            \ 'colorscheme': 'PaperColor',
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

" Coc
" Copied from `:h coc-status`
" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Copied from https://github.com/neoclide/coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" Commented because lightline is used.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" signify
" default updatetime 4000ms is not good for async update
set updatetime=100

" Open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vimtex
set encoding=utf8

""""""""""""""""""
" Plugin Rebinds "
""""""""""""""""""

" FZF
" Map fzf to ctrl-p (! to start in fullscreen.
nnoremap <silent> <C-p> :FZF!<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Coc

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object,
" requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges,
" needs server support, like: coc-tsserver, coc-python
" Commented because <C-d> is used to scroll down.
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
"set mouse=a

" Open new split below or to the right of the current pane.
set splitbelow splitright

" Colorscheme
set background=dark
colorscheme PaperColor

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

set guifont=Fira\ Code\ Retina:h14

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
