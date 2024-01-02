return require('nvim-treesitter').setup(
{
	ensuer_installed = {'c', 'lua', 'vim', 'vimdoc', 'query', 'python', 'bash', 'yaml'},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	}
}
)
