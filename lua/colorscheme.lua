vim.cmd("colorscheme helix")

vim.cmd("highlight Cursor guifg=#6E6078 guibg=#6E6078")
vim.cmd("highlight InsertCursor guifg=#DBBFEF guibg=#DBBFEF")
vim.cmd("highlight Visual guibg=#540099")
vim.cmd("highlight VisualCursor guifg=#DBBFEF guibg=#A4A0E8")

-- vim.cmd("highlight MatchParen guibg=#DBBFEF")

vim.cmd("highlight LineNr guifg=#564E6B")

vim.cmd("highlight CursorLineNr guifg=#DBBFEF")

vim.cmd("highlight CursorLine guifg=NONE guibg=NONE")

vim.o.statusline = "%#DirectoryStatusLine# %F"
vim.cmd("highlight DirectoryStatusLine guibg=#281733")

vim.cmd("highlight Search guibg=#6E6078 guifg=#E8D9E2")
