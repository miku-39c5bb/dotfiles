local custom_pickers = require 'custom.pickers'
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
vim.keymap.set('n', ';', ':', { desc = 'cmd mode' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

local feedkeys = vim.api.nvim_feedkeys
local t = vim.api.nvim_replace_termcodes
vim.keymap.set('n', '<leader>tz', function()
  feedkeys(t('<leader>tg', true, true, true), 'm', false)
  feedkeys(t('<leader>th', true, true, true), 'm', false)
  feedkeys(t('<leader>td', true, true, true), 'm', false)
  feedkeys(t('<leader>tt', true, true, true), 'm', false)
end, { noremap = true, silent = true, desc = 'Toggle distraction free' })

vim.keymap.set('n', '<leader>fg', custom_pickers.pick_repositories)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', 'gx', function()
      local line = vim.fn.getline '.'
      local cursor_col = vim.fn.col '.'
      local pos = 1
      while pos <= #line do
        local open_bracket = line:find('%[', pos)
        if not open_bracket then
          break
        end
        local close_bracket = line:find('%]', open_bracket + 1)
        if not close_bracket then
          break
        end
        local open_paren = line:find('%(', close_bracket + 1)
        if not open_paren then
          break
        end
        local close_paren = line:find('%)', open_paren + 1)
        if not close_paren then
          break
        end
        if (cursor_col >= open_bracket and cursor_col <= close_bracket) or (cursor_col >= open_paren and cursor_col <= close_paren) then
          local url = line:sub(open_paren + 1, close_paren - 1)
          vim.ui.open(url)
          return
        end
        pos = close_paren + 1
      end
      vim.cmd 'normal! gx'
    end, { buffer = true, desc = 'URL opener for markdown' })
  end,
})
