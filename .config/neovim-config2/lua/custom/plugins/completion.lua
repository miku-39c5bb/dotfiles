return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  version = '1.*',
  opts = {
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    keymap = {
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      preset = 'super-tab',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'hide', 'snippet_backward', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    signature = {
      enabled = true,
    },
    cmdline = {
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
    sources = {
      providers = {
        snippets = { score_offset = 1000 },
      },
    },
  },
}
