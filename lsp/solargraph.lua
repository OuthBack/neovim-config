return {
	cmd = {
		os.getenv("GLOBAL_SOLARGRAPH"),
		"stdio",
	},
	filetypes = {
		"ruby",
	},
	flags = {
		debounce_text_changes = 150,
	},
	--on_attach = on_attach,
	root_dir = vim.fn.getcwd(),
	capabilities = capabilities,
	handlers = handlers,
	settings = {
		solargraph = {
			completion = true,
			autoformat = false,
			formatting = true,
			symbols = true,
			definitions = true,
			references = true,
			folding = true,
			highlights = true,
			diagnostics = true,
			rename = true,
			-- Enable this when running with docker compose
			--transport = 'external',
			--externalServer = {
			--    host = 'localhost',
			--    port = '7658',
			--}
		},
	},
}
