vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextStart guisp=#E06C75 gui=underline]]
vim.cmd [[highlight IndentBlanklineContextSpaceChar guifg=#3E4452 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#3E4452 gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"


require("indent_blankline").setup {
   show_current_context = true,
   show_current_context_start = true,
   char_highlight_list = {
     "IndentBlanklineIndent1",
     "IndentBlanklineIndent2",
     "IndentBlanklineIndent3",
     "IndentBlanklineIndent4",
     "IndentBlanklineIndent5",
     "IndentBlanklineIndent6",
     "IndentBlanklineContextSpaceChar",
     "IndentBlanklineContextStart",
     "IndentBlanklineSpaceChar"
   },
}

