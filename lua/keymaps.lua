vim.g.mapleader = " "

vim.keymap.set("n", "gw", ":HopWord<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>f", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", ":History<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":GitFiles<CR>", { noremap = true, silent = true })
