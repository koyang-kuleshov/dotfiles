local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- Color scheme
    use 'sainnhe/gruvbox-material'
    use 'jonathanfilip/vim-lucius'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup()
    end, }
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('bufferline').setup{}
    end, }

    -- Navigation
    use 'scrooloose/nerdtree'
    use 'jistr/vim-nerdtree-tabs'
    use 'majutsushi/tagbar'

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    use 'hrsh7th/cmp-path'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb' -- required by fugitive to :Gbrowse

-- cpiw => copy word into system clipboard
-- cpi' => copy inside single quotes to system clipboard
--- cvi' => paste inside single quotes from system clipboard
-- cP => paste the content from system clipboard to the next line
    use 'christoomey/vim-system-copy'

    use 'Raimondi/delimitMate'
    use 'Yggdroot/indentLine'
    use 'vim-scripts/vim-auto-save'
    use 'tmhedberg/SimpylFold'
    use {'heavenshell/vim-pydocstring', run = 'make install' }

    -- LSP-server
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    -- Autocomplition
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'

    use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "LinArcX/telescope-command-palette.nvim" }

    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/gitsigns.nvim'
    -- use 'ray-x/lsp_signature.nvim'

    -- Python
    use 'mitsuhiko/vim-jinja'
        -- HTML и CSS
    use 'vim-test/vim-test'
    -----------------------------------------------------------
    -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
    use 'idanarye/breeze.vim'
    -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
    use 'alvan/vim-closetag'
    -- Подсвечивает #ffffff
    use 'ap/vim-css-color'

    -- Даже если включена русская раскладка vim команды будут работать
    use 'powerman/vim-plugin-ruscmd'
    -- 'Автоформатирование' кода для всех языков
    -- use 'Chiel92/vim-autoformat'
    -- ]p - вставить на строку выше, [p - ниже
    use 'tpope/vim-unimpaired'
    end
    )
