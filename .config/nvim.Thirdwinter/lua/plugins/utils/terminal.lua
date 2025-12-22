-- return {
--   '2kabhishek/termim.nvim',
--   cmd = { 'Fterm', 'FTerm', 'Sterm', 'STerm', 'Tterm', 'TTerm', 'Vterm', 'VTerm' },
-- }
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<A-q>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts =
  {
    --[[ things you want to change go here]]
  },
  config = function()
    require("toggleterm").setup {
      shade_terminals = false
    }
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    vim.api.nvim_set_keymap("n", "<F9>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<F9>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<F9>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F10>", "<cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<F10>", "<cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<F10>", "<cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-n>", "<cmd>ToggleTermSetName<CR>", { noremap = true, silent = true })
  end,
}
