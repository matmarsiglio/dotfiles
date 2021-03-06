""plug.vim

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jlesquembre/coc-conjure' " extension for clojure
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
Plug 'w0rp/ale'
Plug 'AndrewRadev/tagalong.vim' " helper for html tags
Plug 'brooth/far.vim' " find and replace tool
Plug 'liuchengxu/vista.vim' " show under the cursor item definition
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify' " show vcs diffs at line
Plug 'terryma/vim-multiple-cursors'
Plug 'ayu-theme/ayu-vim'
Plug 'rust-lang/rust.vim'
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

"" COC
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"" Coc Conjure

let g:coc_global_extensions = ['coc-conjure']

"" VISTA

let g:vista_default_executive = 'coc'

let g:vista#renderer#enable_icon = 0

"" TAGALONG -> auto complete html tags closing
let g:tagalong_filetypes = ['html', 'xml', 'tsx', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact', 'javascript']
let g:tagalong_verbose = 1

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

"""""""""""
"" FLOATERM
"""""""""""
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-p> :GFiles<CR>
let g:fzf_preview_window = 'right:60%'

map <leader>g :Ag <cr>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right'), <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITORCONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SIGNIFY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'
let g:ale_linters = {
\'javascript': ['flow', 'eslint'],
\}
let g:ale_fixers = {
\'javascript': ['eslint'],
\}

" Go lang
let g:deoplete#sources#go#builtin_objects=1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/bin/bash
syntax on
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Update file when cursor stops moving and when you focus on Terminal
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" Display extra whitespace
set listchars=tab:»·,trail:·,nbsp:·
set list

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

" Set numbers
set number
set relativenumber
map <leader>rn :set relativenumber!<cr>

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Highlight the current cursor line
set cursorline

" set a default split to the right considering right to left reading
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPLEADER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let g:ctrlp_by_filename = 1

" Fast savingme = 1
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>

map <leader>l :vsplit<cr>:Ggrep "<C-r><C-w>"<cr><Esc>:copen<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Ctrl+X, Ctrl+C and Ctrl+V
" Only works after installing vim-gnome package on Ubuntu 10.04
vnoremap <leader>x "+d
vnoremap <leader>c "+y
nnoremap <leader>v "+p
nnoremap <leader>V "+P
" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,$bd!<cr>

" Useful mappings for managing tabs
nmap <leader>T :tabnew<cr>

" Spell checking
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAVIGATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS, TEXTS AND SCHEMES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

let g:rehash256 = 1
set termguicolors     " enable true colors support
let ayucolor="dark"
colorscheme ayu

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Filetypes support "
au BufNewFile, BufRead *.ejs set syntax=html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENTATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

" Maximum length in line of 100
set colorcolumn=100

" Identations
vnoremap << <gv
vnoremap >> >gv
vnoremap = =gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HELPERS FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" server
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()
autocmd BufWrite *.rs :call DeleteTrailingWS()

" client
autocmd BufWrite *.html :call DeleteTrailingWS()
autocmd BufWrite *.haml :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.ts :call DeleteTrailingWS()
autocmd BufWrite *.jsx :call DeleteTrailingWS()
autocmd BufWrite *.tsx :call DeleteTrailingWS()
autocmd BufWrite *.scss :call DeleteTrailingWS()
autocmd BufWrite *.styl :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.ejs :call DeleteTrailingWS()
autocmd BufWrite *.erb :call DeleteTrailingWS()

" shell
autocmd BufWrite *.vimrc :call DeleteTrailingWS()
autocmd BufWrite *.bashrc :call DeleteTrailingWS()

