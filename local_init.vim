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
"set nobackup 	     " no backup files
"set nowritebackup   " only in case you don't want a backup file while editing
set noswapfile 	     " no swap files

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

colorscheme gruvbox-material
let g:airline_theme = 'gruvbox_material'
let g:gruvbox_material_background = 'hard'
set background=dark
noremap <C-sd> set background=dark<CR>
nnoremap <C-sl> set background=light<CR>
"=====================================================
"Autosave congig
" ====================================================
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

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
" Integration between Incremental search and Easymotion
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

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))


"=====================================================
" SimplyFold settings
"=====================================================
let g:SimpylFold_docstring_preview = 1
" let g:SimpylFold_fold_docstring = 1 " Fold docstrings
" let b:SimpylFold_fold_docstring = 1 " Fold docstrings (buffer local)
" let g:SimpylFold_fold_import = 1    " Fold imports
" letn b:SimpylFold_fold_import = 1    " Fold imports (buffer local)

set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
