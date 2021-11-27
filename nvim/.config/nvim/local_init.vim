"" Local vim.init

"" Set Esc to active in normal mode in terminal
:tnoremap <Esc> <C-\><C-n>

set relativenumber

"" Search down into subfolders
set path+=**

" С этой строкой отлично форматирует html файл, который содержит jinja2
au BufNewFile,BufRead *.html set filetype=htmldjango
autocmd BufRead,BufNewFile *.conf let b:autoformat_autoindent=0

" Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянутся
imap jk <Esc>

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
"Autosave config
" ====================================================
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification
" autocmd FileType python let g:auto_save_postsave_hook = 'PymodeLint'  " this will run :TagsGenerate after each save

"=====================================================
"VimCommander config
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


"=====================================================
" SimplyFold settings
"=====================================================
" set nofoldenable
set foldmethod=indent
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0 " Fold docstrings
let b:SimpylFold_fold_docstring = 0 " Fold docstrings (buffer local)
let g:SimpylFold_fold_import = 0    " Fold imports
let b:SimpylFold_fold_import = 0    " Fold imports (buffer local)

set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping

"=====================================================
" Telescope settings
"=====================================================
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>fc <cmd>Vim commands<cr>
nnoremap <leader>fk <cmd>Vim keymaps<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
lua << EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
"=====================================================
" Markdown-preview settings
"=====================================================
" set to 1, nvim will open the preview window after entering the markdown buffer
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 1

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
let g:mkdp_open_ip = ''

" specify browser to open preview page
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

"=====================================================
" vimtex settings
"=====================================================
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


"=====================================================
" Pydocstring settings
"=====================================================
" Possible values = ['google', 'numpy', 'sphinx']
let g:pydocstring_formatter = 'google'
nmap <silent> <C-s> <Plug>(pydocstring)
let g:pydocstring_templates_path = '~/dotfiles/nvim/.config/nvim/docstring_templates'

