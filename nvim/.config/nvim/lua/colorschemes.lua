
-- Цветовая схема
vim.o.termguicolors = true      --  24-bit RGB colors
vim.cmd'colorscheme gruvbox-material'

vim.g.gruvbox_material_palette = 'material'
vim.g.gruvbox_material_background = '`hard`'
vim.g.background = 'dark'

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 -- override = {
 --  zsh = {
 --    icon = "",
 --    color = "#428850",
 --    name = "Zsh"
 --  }
 -- };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nerdtree'}
}

-- map <F12> :call ToggleBg()<CR>
-- function! ToggleBg()
--     if &background == 'dark'
--         color lucius
--         set background=light
--     else
--         let g:airline_theme = 'gruvbox_material'
--         let g:gruvbox_material_background = 'hard'
--         set background=dark
--         colorscheme gruvbox-material
--     endif
-- endfunc

