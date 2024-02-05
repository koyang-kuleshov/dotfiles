local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.flake8.with { filetypes = { 'python' } },
      null_ls.builtins.formatting.lua_format,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd.with { filetypes = {
        'graphql',
        'json',
        'jsonc',
        'markdown',
        'markdown.mdx',
        'python',
        'yaml',
  },
}
    },
	on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
						filter = function(client)
							return client.name == 'null-ls'
						end
					 })
  -- vim.lsp.buf.formatting_sync()
        end,
          })
    end
  end,
})

