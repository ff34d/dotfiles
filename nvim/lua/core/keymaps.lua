vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Files
vim.keymap.set("n", "<S-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree", silent = true })

-- Telescope
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })

-- Buffers
vim.keymap.set("n", "<Tab>", "<cmd>BufferNext<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<S-w>", "<cmd>BufferClose<cr>", { desc = "Buffer close" })
