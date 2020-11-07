"" Local vim.init

"" Set Esc to active in normal mode in terminal
:tnoremap <Esc> <C-\><C-n>

set relativenumber

"" Search down into subfolders
set path+=**

" Отключение стрелок
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Отключаем бэкапы и своп-файлы
"set nobackup     " no backup files
"set nowritebackup   " only in case you don't want a backup file while editing
set noswapfile     " no swap files

"" При переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

"" Show a visual line under the cursor's current line
set cursorline

"" Copy selected text to system clipboard (reaquires gvim(vim-gtk3) installed)
vnoremap <C-c> "*Y :let @+=*<CR>
map <C-p> "+P

let g:airline_theme = 'gruvbox_material'
let g:gruvbox_material_background = 'hard'
set background=dark
colorscheme gruvbox-material
map <F12> :call ToggleBg()<CR>
function! ToggleBg()
    if &background == 'dark'
        color lucius
        set background=light
    else
        let g:airline_theme = 'gruvbox_material'
        let g:gruvbox_material_background = 'hard'
        set background=dark
        colorscheme gruvbox-material
    endif
endfunc


"=====================================================
"Autosave congig
" ====================================================
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification
" autocmd FileType python let g:auto_save_postsave_hook = 'PymodeLint'  " this will run :TagsGenerate after each save

"=====================================================
"VimCommander congig
" ====================================================
noremap <silent> <F9> :cal VimCommanderToggle()<CR>


"=====================================================
"CTRLP settings
" ====================================================
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_map = 'F3'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$'
  \ }

map <F3> :CtrlP <CR>

" ====================================================
" Easymotion settings
" ====================================================

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>W <Plug>(easymotion-bd-w)
nmap <Leader>W <Plug>(easymotion-overwin-w)

"Включение проверки русского языка
" map <C-x> :setlocal spell spelllang=ru_ru<CR>
" map <C-z> :setlocal spell spelllang=<CR>


"=====================================================
" Incremental search
"=====================================================
map z/ <Plug>(incsearch-easymotion-/)
nmap z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


"=====================================================
"Integration between Incremental search and Easymotion
"=====================================================

"You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /s  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))


"=====================================================
" SimplyFold settings
"=====================================================
" set nofoldenable
let g:SimpylFold_docstring_preview = 1
" let g:SimpylFold_fold_docstring = 1 " Fold docstrings
" let b:SimpylFold_fold_docstring = 1 " Fold docstrings (buffer local)
let g:SimpylFold_fold_import = 0    " Fold imports
let b:SimpylFold_fold_import = 0    " Fold imports (buffer local)

set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping


"=====================================================
" Python-mode setting
"=====================================================
" Autofold
let g:pymode_folding = 1

let g:pymode_indent = 1
let g:pymode_motion = 1

" Autocompletion
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport = 1
let g:pymode_rope_regenerate_on_write = 1

" Remove whitespaces
let g:pymode_trim_whitespaces = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'M-k'

" Linters
let g:pymode_lint = 0
let g:pymode_lint_checker = ['pylint', 'pyflakes', 'pep8']
let g:pymode_lint_ignore= ['E501', 'W601', 'C0110', 'C0200', 'E402']
let g:pymode_lint_cwindow = 0
let g:pymode_lint_sort = ['E', 'C', 'I', 'W']
let g:pymode_lint_unmodified = 1
let g:pymode_lint_message = 1
let g:pymode_lint_signs = 1
let g:pymode_lint_todo_symbol = 'WW'
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_error_symbol = 'EE'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'

" Virtualenv
let g:pymode_virtualenv = 1

" Breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" Syntax
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" возможность запускать код
let g:pymode_run = 1
