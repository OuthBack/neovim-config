local capabilities = require("cmp_nvim_lsp").default_capabilities()
local rust_tools = require("rust-tools")

vim.lsp.enable("ts_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("lua_ls")
vim.lsp.enable("dartls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")


--  TODO: RUBOCOP NEEDS TO BE INSTALLED GLOBALLY
-- vim.lsp.config("rubocop", {
--     cmd = { os.getenv( "RUBOCOP_PATH" ),  "--lsp" }
-- })


vim.lsp.config("rust_analyzer", {
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})

-- rust_tools.setup({
-- 	server = {
-- 		on_attach = function(_, bufnr)
-- 			-- Hover actions
-- 			vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
-- 			-- Code action groups
-- 			vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
-- 		end,
-- 	},
-- })

-- vim.cmd([[packadd copilot.vim]])
