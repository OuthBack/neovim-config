return {
    cmd = { os.getenv("GLOBAL_PYRIGHT") }, 
	settings = {
		python = {
			pythonPath = vim.fn.exepath("python3"),
		},
	},
}
