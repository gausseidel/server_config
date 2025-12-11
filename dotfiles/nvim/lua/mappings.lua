require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Esci da nvim con Ctrl+x
map("n", "<C-x>", "<cmd>q<cr>", { desc = "Exit Neovim" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.api.nvim_set_keymap('v', '<leader>y', '<cmd>lua require("osc52").copy_visual()<CR>', { noremap = true, silent = true })

