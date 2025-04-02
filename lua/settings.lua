vim.o.number = true

vim.o.guicursor = "n:block-Cursor,v:block-VisualCursor,i:block-InsertCursor"

vim.o.wrap = false
vim.o.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 5

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.o.mouse = "nvi"

vim.o.signcolumn = "yes"

vim.o.relativenumber = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
local undodir = os.getenv("HOME") .. "/.nvim/undodir"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p")
end
