vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<C-q>", vim.cmd.q)
vim.keymap.set("n", "<C-s>", vim.cmd.w)

-- Window Management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>") -- close current split window
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { noremap = true, silent = true }) -- Increase height
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { noremap = true, silent = true }) -- Decrease height
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { noremap = true, silent = true }) -- Decrease width
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { noremap = true, silent = true }) -- Increase width

-- Tab Management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --  go to previous tab
vim.keymap.set("n", "<leader>tm", "<cmd>tabnew %<CR>") --  move current buffer to new tab

-- Neo-Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Fold
vim.keymap.set("n", "<C-Z>", "za") -- toggle fold
