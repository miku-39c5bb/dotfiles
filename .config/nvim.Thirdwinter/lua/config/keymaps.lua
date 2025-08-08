-- [[ 基本键位映射 ]]
--  参见 `:help vim.keymap.set()`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>Q', '<Cmd>qa!<CR>', { noremap = true, silent = true, desc = 'Close Nvim' })
vim.keymap.set('n', '<leader>q', '<Cmd>confirm q<CR>', { noremap = true, silent = true, desc = '退出' })
vim.keymap.set('n', '<leader>w', '<Cmd>w!<CR>', { noremap = true, silent = true, desc = 'Save' })
vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.open_float { source = true }
end, { noremap = true, silent = true, desc = 'Diagnostic Info' })

-- 分割当前行，光标块内的字符在当前行
vim.keymap.set('n', '<leader>k', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))   -- 获取当前光标位置
  local line = vim.api.nvim_get_current_line()              -- 获取当前行内容
  local before = line:sub(1, col + 1)                       -- 光标前的内容
  local after = line:sub(col + 2)                           -- 光标后的内容
  vim.api.nvim_set_current_line(before)                     -- 设置当前行为光标前的内容
  vim.api.nvim_buf_set_lines(0, row, row, false, { after }) -- 在当前行后插入光标后的内容
end, { desc = '分割当前行', noremap = true, silent = true })

--INFO: NeoVide
if vim.g.neovide then
  vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })      -- Save
  vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })         -- Copy
  vim.keymap.set('i', '<C-v>', '"+P', { noremap = true, silent = true })         -- Paste normal mode
  -- vim.keymap.set('v', '<C-v>', '"+P', { noremap = true, silent = true }) -- Paste visual mode
  vim.keymap.set('c', '<C-v>', '<C-R>+', { noremap = true, silent = true })      -- Paste command mode
  vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli', { noremap = true, silent = true }) -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<C-R>+', { noremap = true, silent = true })
vim.keymap.set('t', '<C-v>', '<C-R>+', { noremap = true, silent = true })
vim.keymap.set('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>h', '^', { desc = "jump first char in line" })

--  参见 `:help wincmd` 了解所有窗口命令的列表
--INFO: 窗口分割
vim.keymap.set('n', '\\', '<CMD>:sp<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '|', '<CMD>:vsp<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '+', '<C-w>|<C-w>_', { desc = 'Maximize nvim pane' })
vim.keymap.set('n', '=', '<C-w>=', { desc = 'Restore nvim panes' })

--INFO: 窗口移动
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = '将焦点移动到左侧窗口' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = '将焦点移动到右侧窗口' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = '将焦点移动到下方窗口' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = '将焦点移动到上方窗口' })

--INFO: 基础相关：
vim.keymap.set('n', '<C-Up>', '<Cmd>resize -2<CR>', { desc = 'Resize split up' })
vim.keymap.set('n', '<C-Down>', '<Cmd>resize +2<CR>', { desc = 'Resize split down' })
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', { desc = 'Resize split left' })
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', { desc = 'Resize split right' })

vim.keymap.set('n', '<A-i>', '<cmd>m .-2<cr>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<cmd>m .+1<cr>==', { noremap = true, silent = true })
vim.keymap.set('i', '<A-i>', '<esc><cmd>m .-2<cr>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .+1<cr>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<A-i>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('n', '<C-a>', '<cmd>normal! ggVG<cr>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-a>', '<esc><cmd>normal! ggVG<cr>', { noremap = true, silent = true })

--INFO: 关于注释
vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', { desc = '注释' })
vim.api.nvim_set_keymap('v', '<leader>/', 'gcc<Esc>', { desc = '注释' })

--INFO: 关于Package Manager
vim.keymap.set('n', '<Leader>pl', '<Cmd>Lazy<CR>', { desc = 'Lazy', noremap = true, silent = true })
vim.keymap.set('n', '<Leader>pm', '<Cmd>Mason<CR>', { desc = 'Mason', noremap = true, silent = true })

-- INFO: noice hover doc scroll
vim.keymap.set({ 'n', 's' }, '<c-f>', function()
  if not require('noice.lsp').scroll(4) then
    return '<c-f>'
  end
end, { silent = true, expr = true })

vim.keymap.set({ 'n', 's' }, '<c-b>', function()
  if not require('noice.lsp').scroll(-4) then
    return '<c-b>'
  end
end, { silent = true, expr = true })

-- NOTE: 驼峰转蛇形
function _G.camel_to_snake()
  -- 获取当前模式
  local mode = vim.api.nvim_get_mode().mode

  -- 处理 Visual 模式
  if mode == 'n' then
    local word = vim.fn.expand('<cword>')
    if word == '' then return end

    -- 转换逻辑
    local converted = word:gsub("([a-z])([A-Z])", "%1_%2")
        :gsub("([A-Z]+)([A-Z][a-z])", "%1_%2")
        :lower()

    -- 替换当前单词
    vim.cmd('normal! ciw' .. converted)
  end
end

-- 绑定到 <leader>ts
vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua camel_to_snake()<CR>', { noremap = true, silent = true })

--INFO: Set Emacs keybindings in insert mode
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-f>', '<C-Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-b>', '<C-Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-d>', '<Del>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<C-o>D', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-y>', '<C-r>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-n>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-p>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-h>', '<BS>', { noremap = true, silent = true })
