local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Системный буфер обмена
map('v', 'y', 'y:call system("wl-copy", @@)<CR>', default_opts)
map('n', '<C-y>', '"+y', {})

-- Comment line
map('n', '<C-_>', ':Commentary<CR>', default_opts)
map('v', '<C-_>', ':Commentary<CR>', default_opts)

-- Insert text above line
map('n', '<Leader>p', '"+gP<CR>', default_opts)

-- map('n', 'YY', '"+y<CR>', default_opts)
-- map('n', 'XX', '"+x<CR>', default_opts)

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
-- map('n', '<Leader>h', ':hsplit<CR>', default_opts)

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

-- Пролистнуть на страницу вниз / вверх (как в браузерах)
map('n', '<Space>', '<PageDown> zz', default_opts)
map('n', '<C-Space>', '<PageUp> zz', default_opts)

-- По Leader+Leader очищаем последний поиск с подсветкой
map('n', '<Leader><Leader>', ':nohl<CR>', default_opts)
-- shift + F1 = удалить пустые строки
map('n', '<S-F1>', ':g/^$/d<CR>', default_opts)

-- <S-F9> Открыть всю nvim конфигурацию для редактирования
map('n', '<S-F9>', ':e ~/.config/nvim/init.lua<CR>:e ~/.config/nvim/lua/plugins.lua<CR>:e ~/.config/nvim/lua/settings.lua<CR>:e ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })

-- Дерево файлов
map('n', '<leader>o', ':Neotree toggle current reveal_force_cwd float<CR>', default_opts)
map('n', '<leader>b', ':Neotree toggle show buffers right<CR>', default_opts)

-- <F4>  Показ дерева классов и функций, плагин majutsushi/tagbar
map('n', '<leader>s', ':TagbarToggle<CR>', default_opts)

-- Telescope
-- <C-F5> Поиск слова под курсором
map('n', '<leader>fw', 'require("telescope.builtin").grep_string()<CR>', default_opts)
-- <S-F4> Поиск слова в модальном окошке
map('n', '<S-F5>', 'require("telescope.builtin").live_grep()<CR>', default_opts)
-- fzf
map('n', '<leader>f', 'require("telescope.builtin").find_files()<CR>', default_opts)
map('n', '<leader>g', 'require("telescope.builtin").git_branches.()<CR>', default_opts)
map('n', '<leader>h', ':Telescope<CR>', default_opts)

-- Invoke Pydocstring
map('n', '<C-S-d>', 'Pydocstring<CR>', default_opts)

-- VIM TEST
map('n', '<leader>t', ':TestNearest<CR>', default_opts)
-- map('n', '<Leader>T', ':TestFile<CR>', default_opts)
-- map('n', '<Leader>a', ':TestSuite<CR>', default_opts)
map('n', '<leader>l', ':TestLast<CR>', default_opts)
map('n', '<leader>g', ':TestVisit<CR>', default_opts)
