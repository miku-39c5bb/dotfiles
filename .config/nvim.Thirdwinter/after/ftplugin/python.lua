-- -- basedpyright
-- vim.lsp.start {
--   name = 'basedpyright',
--   cmd = { 'basedpyright-langserver', '--stdio' },
--   filetypes = { 'python' },
--   settings = {
--     basedpyright = {
--       analysis = {
--         typeCheckingMode = 'basic',  -- 'off' / 'basic' / 'strict'
--       },
--     },
--   },
-- }

-- -- basedpyright ruff
-- -- LSP for types and completions
-- vim.lsp.start {
--   name = 'basedpyright',
--   cmd = { 'basedpyright-langserver', '--stdio' },
--   settings = {
--     basedpyright = {
--       analysis = { typeCheckingMode = 'basic' },
--     },
--   },
-- }
-- -- Linter/Formatter (super fast)
-- vim.lsp.start {
--   name = 'ruff',
--   cmd = { 'ruff', 'server' },
--   filetypes = { 'python' },
-- }

-- python-lsp-server
vim.lsp.start {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
      },
    },
  },
}
