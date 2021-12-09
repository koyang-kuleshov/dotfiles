local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt -- global/buffer/windows-scoped
local env = vim.env

-- Главные
opt.colorcolumn = '80'              -- Разделитель на 80 символов
opt.cursorline = true               -- Подсветка строки с курсором
opt.number = true                   -- Включаем нумерацию строк
opt.relativenumber = true           -- Вкл. относительную нумерацию строк
opt.so=999                          -- Курсор всегда в центре экрана
opt.undofile = true                 -- Возможность отката назад
opt.splitright = true               -- vertical split вправо
opt.splitbelow = true               -- horizontal split вниз
g.hidden = true
g.hlsearch = true
g.incsearch = true
g.ignorecase = true
g.smartcase = true
g.fileformats = 'unix','dos','mac'
g.mouse = 'nv'
g.mousemodel = 'popup'
g.gcr = 'a:blinkon0'
g.scrolloff = 8
g.autoread = true
-- g.noswapfile = true
opt.swapfile = false
g.clipboard = 'unnamed,unnamedplus'

-- Табы и отступы
cmd([[
filetype indent plugin on
syntax enable
let python_highlight_all = 1
]])

-- При переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
cmd([[
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END
]])
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.softtabstop = 0
opt.smartindent = true    -- autoindent new lines
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType sql,text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
cmd [[
autocmd FileType sql,xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd[[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]

-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)

-- Установки для плагинов

-- LSP settings
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == 'sumneko_lua' then
        -- only apply these settings for the "sumneko_lua" server
        opts.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the 'vim', 'use' global
                    globals = {'vim', 'use'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    end
    server:setup(opts)
end)


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
        autocomplete = false
      },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
        end,
      },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
      end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    },
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    -- root_dir = function(startpath)
    --    return M.search_ancestors(startpath, matcher)
    --  end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          typeCheckingMode = 'basic', -- basic, strict
          useLibraryCodeForTypes = true
        }
      }
    },
    single_file_support = true
  }
  require('gitsigns').setup()

  -- cfg_sign = {
  -- debug = false, -- set to true to enable debug logging
  -- log_path = "debug_log_file_path", -- debug log path
  -- verbose = false, -- show debug line number

  -- bind = true, -- This is mandatory, otherwise border config won't get registered.
  --              -- If you want to hook lspsaga or other signature handler, pls set to false
  -- doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  --                -- set to 0 if you DO NOT want any API comments be shown
  --                -- This setting only take effect in insert mode, it does not affect signature help in normal
  --                -- mode, 10 by default

  -- floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  -- floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- -- will set to true when fully tested, set to false will use whichever side has more space
  -- -- this setting will be helpful if you do not want the PUM and floating win overlap
  -- fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  -- hint_enable = true, -- virtual hint enable
  -- hint_prefix = "🐼 ",  -- Panda for parameter
  -- hint_scheme = "String",
  -- use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  -- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  -- max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  --                  -- to view the hiding contents
  -- max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  -- handler_opts = {
  --   border = "rounded"   -- double, rounded, single, shadow, none
  -- },

  -- always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  -- auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  -- extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  -- padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  -- transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  -- shadow_blend = 36, -- if you using shadow as border use this set the opacity
  -- shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  -- timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  -- toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
-- }

-- -- recommanded:
-- require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- -- You can also do this inside lsp on_attach
-- -- note: on_attach deprecated
-- require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
end

-- SQL server
-- https://github.com/joe-re/sql-language-server
-- sql-language-server up --method stdio
-- g:LanguageClient_serverCommands = {
--\ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
--\ }

-- Autosave config
g.auto_save = 1  -- enable AutoSave on Vim startup
g.auto_save_in_insert_mode = 0  -- do not save while in insert mode
g.auto_save_silent = 1  -- do not display the auto-save notification

-- Markdown-preview settings
-- set to 1, nvim will open the preview window after entering the markdown buffer
g.mkdp_auto_start = 1

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
g.mkdp_auto_close = 0

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
g.mkdp_refresh_slow = 1

-- set to 1, the MarkdownPreview command can be use for all files,
-- by default it can be use in markdown file
g.mkdp_command_for_global = 0

-- set to 1, preview server available to others in your network
-- by default, the server listens on localhost (127.0.0.1)
g.mkdp_open_to_the_world = 0

-- use custom IP to open preview page
-- useful when you work in remote vim and preview on local browser
-- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
g.mkdp_open_ip = ''

-- specify browser to open preview page
g.mkdp_browser = ''

-- set to 1, echo preview page url in command line when open preview page
g.mkdp_echo_preview_url = 0

-- a custom vim function name to open preview page
-- this function will receive url as param
g.mkdp_browserfunc = ''

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
g.mkdp_preview_options = {
     mkit = {},
     katex = {},
     uml = {},
     maid = {},
     disable_sync_scroll = 0,
     sync_scroll_type = 'middle',
     hide_yaml_meta = 1,
     sequence_diagrams = {},
     flowchart_diagrams = {},
     content_editable = 'v:false',
     disable_filename = 0,
}

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
g.mkdp_markdown_css = ''

-- use a custom highlight style must absolute path
-- like '/Users/username/highlight.css' or expand('~/highlight.css')
g.mkdp_highlight_css = ''

-- use a custom port to start server or random for empty
g.mkdp_port = ''

-- preview page title
-- ${name} will be replace with the file name
g.mkdp_page_title = '「${name}」'

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
g.mkdp_filetypes = {'markdown'}


-- Pydocstring settings
-- Possible values = ['google', 'numpy', 'sphinx']
g.pydocstring_formatter = 'google'
g.pydocstring_templates_path = '~/dotfiles/nvim/.config/nvim/docstring_templates'

-- Nerdtree
g.NERDTreeShowHidden = 1

-- Tagbar
g.tagbar_compact = 1
g.tagbar_sort = 0

