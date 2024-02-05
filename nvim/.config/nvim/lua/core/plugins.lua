local fn = vim.fn

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct


return require('lazy').setup({
    -- Color scheme
  {
    'sainnhe/gruvbox-material',
    lazy=false,
    priority=1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  { 'jonathanfilip/vim-lucius', lazy = true },

  -- Neotree
	{
    'nvim-neo-tree/neo-tree.nvim',
    lazy = 'false',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
-- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
	    },
	},
  -- Bufferline and statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim'
      }
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },

  -- Treesitter for highliting and Telescope for searching
	{'nvim-treesitter/nvim-treesitter'},
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    -- branch = '0.1.x',
      dependencies = {'nvim-lua/plenary.nvim'}
  },

  -- LSP
	{'neovim/nvim-lspconfig'},
	{
	    'williamboman/mason.nvim',
      build = ':MasonUpdate',
	    lazy = false,
	    config = function()
		require('mason').setup()
	    end

	},

-- cpiw => copy word into system clipboard
-- cpi' => copy inside single quotes to system clipboard
-- cvi' => paste inside single quotes from system clipboard
-- cP => copy the current line directly
-- cV => paste the content of system clipboard to the next line
   {'christoomey/vim-system-copy'},

  -- Autocomplete
  {'hrsh7th/cmp-path'},
	{'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},

  -- Commenting with C-/
  {'tpope/vim-commentary'},

  -- Surrond text ys${
  {'tpope/vim-surround'},

  -- Added pairs for {. S-Tab or C-Gg
  {'Raimondi/delimitMate'},

  -- Add | for indents
  {'Yggdroot/indentLine'},

  -- Show module structure
  {'majutsushi/tagbar'},

  -- Show signs from git status
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Show CSS-colors #ffffff
  -- {'ap/vim-css-color'},

  -- Linting
  {
		'nvimtools/none-ls.nvim',
		dependencies = {'nvim-lua/plenary.nvim'}
	},

  -- Terminal
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- Даже если включена русская раскладка vim команды будут работать
  {'powerman/vim-plugin-ruscmd'},

  -- https://github.com/vim-test/vim-test
  {'vim-test/vim-test'},

  -- Autosave
  {'vim-scripts/vim-auto-save'}

  -- Snipets
  -- {'SirVer/ultisnips'},
  -- {'quangnguyen30192/cmp-nvim-ultisnips'},

  -- Show bindings
	-- {'folke/which-key.nvim', lazy = false},


  -- TODO: check linter, autosave

	-- {
	-- 	'heavenshell/vim-pydocstring',
	-- 	run = 'make install'
	-- }


    -- 'tmhedberg/SimpylFold'


    -----------------------------------------------------------
    -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
    -- 'idanarye/breeze.vim'

    -- 'Автоформатирование' кода для всех языков
    -- -- 'Chiel92/vim-autoformat'
    -- ]p - вставить на строку выше, [p - ниже
    -- 'tpope/vim-unimpaired'
    -- end
    }
    )
