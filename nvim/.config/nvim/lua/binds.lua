local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Системный буфер обмена
map('v', 'y', 'y:call system("wl-copy", @@)<CR>', default_opts)
map('n', '<C-S>c', '"+y', {})

-- Comment line
map('n', '<C-_>', ':Commentary<CR>', default_opts)
map('v', '<C-_>', ':Commentary<CR>', default_opts)

-- Insert text above line
map('n', '<Leader>p', '"+gP<CR>', default_opts)

map('n', 'YY', '"+y<CR>', default_opts)
map('n', 'XX', '"+x<CR>', default_opts)

-- Типа 'Нажимает' на ESC при быстром нажатии jk, чтобы не тянутся
map('i', 'jk', '<Esc>', {noremap = true})
-- Сохранение по CTRL-s , как в нормальном, так и в insert режиме
map('n', '<C-s>', ':w<CR>',  default_opts)
map('i', '<C-s>', '<Esc>:w<CR>', default_opts)
-- Переключение вкладок с помощью Leader+q/w (akinsho/bufferline.nvim)
map('n', '<Leader>w', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<Leader>q', ':BufferLineCyclePrev<CR>', default_opts)
map('n', '<Leader>c', ':bd<CR>', default_opts)

map('n', '<Leader>v', ':vsplit<CR>', default_opts)
map('n', '<Leader>h', ':hsplit<CR>', default_opts)

map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

map('n', 'n', 'nzzzv', default_opts)
map('n', 'N', 'Nzzzv', default_opts)

map('c', 'W!', 'w!', default_opts)
map('c', 'Q!', 'q!', default_opts)
map('c', 'Qall!', 'qall!', default_opts)
map('c', 'Wq', 'wq', default_opts)
map('c', 'Wa', 'wa', default_opts)
map('c', 'wQ', 'wq', default_opts) 
map('c', 'WQ', 'wq', default_opts)
map('c', 'W', 'w', default_opts) 
map('c', 'Q', 'q', default_opts)
map('c', 'Qall', 'qall', default_opts)

-- map('n', 'C-S-s' <Plug>(pydocstring))

-- Пролистнуть на страницу вниз / вверх (как в браузерах)
map('n', '<Space>', '<PageDown> zz', default_opts)
map('n', '<C-Space>', '<PageUp> zz', default_opts)

-- По F1 очищаем последний поиск с подсветкой
map('n', '<Leader><Space>', ':nohl<CR>', default_opts)
-- shift + F1 = удалить пустые строки
map('n', '<S-F1>', ':g/^$/d<CR>', default_opts)
-- <C-F9> перечитать конфигурацию nvim Может не работать, если echo $TERM  xterm-256color
map('n', '<C-F9>', ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/opts.lua<CR>:so ~/.config/nvim/lua/binds.lua<CR>', { noremap = true })
-- <S-F9> Открыть всю nvim конфигурацию для редактирования
map('n', '<S-F9>', ':e ~/.config/nvim/init.lua<CR>:e ~/.config/nvim/lua/plugins.lua<CR>:e ~/.config/nvim/lua/settings.lua<CR>:e ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })
-- <F2> дерево файлов.
map('n', '<F2>', ':NERDTreeToggle<CR>', default_opts)
-- <F4>  Показ дерева классов и функций, плагин majutsushi/tagbar
map('n', '<F4>', ':TagbarToggle<CR>', default_opts)

-- Telescope
map('n', '<C-p>', 'require("telescope.builtin").buffers()<cr>', default_opts)
-- <F4> Поиск слова под курсором
map('n', '<C-F5>', 'require("telescope.builtin").grep_string()<cr>', default_opts)
-- <S-F4> Поиск слова в модальном окошке
map('n', '<S-F5>', 'require("telescope.builtin").live_grep()<cr>', default_opts)
-- fzf
map('n', '<C-a>', 'require("telescope.builtin").find_files()<cr>', default_opts)

-- Invoke Pydocstring
map('n', 'C-S-d', 'Pydocstring<CR>', default_opts)
