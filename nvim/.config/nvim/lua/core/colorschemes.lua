-- Colorsheme
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
