-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-Left>", "<C-w>l", {})
vim.keymap.set("n", "<C-Right>", "<C-w>h", {})

-- Toggle Term Keymaps

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
