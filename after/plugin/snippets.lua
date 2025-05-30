local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-k>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-M-n>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-M-p>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-e>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
