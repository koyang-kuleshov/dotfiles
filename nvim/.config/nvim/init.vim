" vim-bootstrap

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "html,javascript,python,typescript"
let g:vim_bootstrap_editor = "nvim" " nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

" Syntax highlight
" Default highlight is better than polyglot
let python_highlight_all = 1
let g:polyglot_disabled = ['python']

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'avelino/vim-bootstrap-updater'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse

if isdirectory('/usr/local/opt/fzf')
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
"" Plug 'xolox/vim-misc'
"" Plug 'xolox/vim-session'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Color
" Plug 'tomasr/molokai'
"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'


"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" Python Bundle
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'


" vuejs
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'



"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab
autocmd FileType go let b:go_fmt_options = {
\ 'goimports': '-local ' .
\ trim(system('{cd '. shellescape(expand('%:h')) .' && go list -m;}')),
\ }

set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
set shell=$SHELL
else
set shell=/bin/sh
endif

" session management
" let g:session_directory = "~/.config/nvim/session"
" let g:session_autoload = "yes"
" let g:session_autosave = "yes"
" let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
let python_highlight_all = 1
set ruler
set number

let no_buffers_menu=1
" silent! colorscheme molokai

set mouse=nv
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
endif
else
    let g:CSApprox_loaded = 1

    " IndentLine
    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1


endif



"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=8

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>g :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>


"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
function s:setupWrapping()
set wrap
set wm=2
set textwidth=80
endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
autocmd!
autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
autocmd!
autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
autocmd!
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gsh :Git push<CR>
noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
" nnoremap <leader>so :OpenSession<Space>
" nnoremap <leader>ss :SaveSession<Space>
" nnoremap <leader>sd :DeleteSession<CR>
" nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
"nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=['~/dotfiles/nvim/.config/nvim/plugged/ultisnips/', 'UltiSnips']
let g:ultisnips_python_quoting_style='single'

" ale
let g:ale_linters = {'python': ['pylint']}
" let g:ale_python_flake8_use_global = 0
let g:ale_python_pylint_options = '--disable=import-error'
" let g:ale_linters_ignore = {}
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines'],
            \'python': ['reorder-python-imports', 'autopep8']}
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 0
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>l :ALELint

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" if has('macunix')
" pbcopy for OSX copy/paste
" vmap <C-x> :!pbcopy<CR>
" vmap <C-c> :w !pbcopy<CR><CR>
" endif

"" Buffer nav
"noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
"noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
" vmap < <gv
" vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" javascript
let g:javascript_enable_domhtmlcss = 1
autocmd Filetype js setlocal ts=2 sw=2 expandtab colorcolumn=80

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2 colorcolumn=80
augroup END


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=80
      \ formatoptions+=croq softtabstop=4
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" ale
" \'python': ['pylint', 'pycodestyle', 'flake8'], })
" TODO: Uncomment next strings if ale not work
" call extend(g:ale_linters, {
"       \'python': ['pylint', 'pycodestyle'], })

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1



" typescript
let g:yats_host_keyword = 1


" vuejs
" vim vue
let g:vue_disable_pre_processors=1
" vim vue plugin
let g:vim_vue_plugin_load_full_syntax = 1


"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
  source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
endif
