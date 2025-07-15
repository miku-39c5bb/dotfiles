----------------------
--- neovide
-- vim.g.neovide_fullscreen = true
-- vim.g.neovide_opacity = 0.8  -- 0 ~ 1，越小越透明

----------------------
--- customize
vim.o.number = true
vim.o.relativenumber = true

vim.o.laststatus = 0
vim.o.showmode = false  -- 不在状态栏显示 -- INSERT --
vim.o.ruler = false     -- 不显示右下角行号列

----------------------
--- keymap
vim.keymap.set('i', 'jk', '<esc>', { noremap = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Move cursor down' })
vim.keymap.set('x', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Move cursor down' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Move cursor up' })
vim.keymap.set('x', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Move cursor up' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '\\', '<CMD>:sp<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '|', '<CMD>:vsp<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Go to next qf item' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'Go to prev qf item' })
vim.keymap.set('n', '<C-d>', '5j', { desc = 'Scroll down by 5 lines' })
vim.keymap.set('n', '<C-u>', '5k', { desc = 'Scroll up by 5 lines' })
vim.keymap.set('n', 'L', '<C-^>', { noremap = true, desc = 'Go to next buffer' })
vim.keymap.set('n', 'H', '<C-^>', { noremap = true, desc = 'Go to prev buffer' })
vim.keymap.set('n', '+', '<C-w>|<C-w>_', { desc = 'Maximize nvim pane' })
vim.keymap.set('n', '=', '<C-w>=', { desc = 'Restore nvim panes' })
vim.keymap.set('v', 'p', '"_dP', { noremap = true })
vim.keymap.set('v', '<leader>p', 'p', { noremap = true })
vim.keymap.set('n', '<space>X', '<cmd>source %<cr>', { desc = 'Run this lua file' })
vim.keymap.set('n', '<space>x', ':.lua<cr>', { desc = 'Run this line' })
vim.keymap.set('v', '<space>x', ':lua<cr>', { desc = 'Run selection' })
vim.keymap.set('n', '<A-i>', '<CMD>:terminal<CR>', { desc = 'Open termial' })
vim.keymap.set('n', ';', ':', { desc = 'cmd mode' })
vim.keymap.set('t', '<M-\\>', [[<C-\><C-n>]], { noremap = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set("n", "<F11>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { noremap = true, silent = true, desc = "Toggle fullscreen in Neovide" })

vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })

----------------------
-- 设置默认字体名和大小
-- vim.g.gui_font_name = "FiraCode Nerd Font"
vim.g.gui_font_name = "Maple Mono NF CN"
vim.g.gui_font_size = 16

-- 应用字体
local function set_guifont()
  vim.o.guifont = string.format("%s:h%d", vim.g.gui_font_name, vim.g.gui_font_size)
end

set_guifont()

-- 缩小字体
vim.keymap.set("n", "<C-->", function()
  vim.g.gui_font_size = vim.g.gui_font_size - 1
  set_guifont()
end)

-- 放大字体
vim.keymap.set("n", "<C-=>", function()
  vim.g.gui_font_size = vim.g.gui_font_size + 1
  set_guifont()
end)

-- 重置字体大小
vim.keymap.set("n", "<C-0>", function()
  vim.g.gui_font_size = 14
  set_guifont()
end)

----------------------
--- plugin
--- export http_proxy="http://127.0.0.1:7890"
--- export https_proxy="http://127.0.0.1:7890"
--- git clone https://github.com/folke/lazy.nvim.git `
---   $env:LOCALAPPDATA\nvim-data\site\pack\lazy\start\lazy.nvim
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
})

vim.cmd.colorscheme('catppuccin')

