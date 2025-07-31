local cp = require('catppuccin.palettes').get_palette()
-- local config = require('catppuccin.config').options
local catppuccin = {}

catppuccin.mode_color = {
  n = cp.blue,
  i = cp.green,
  v = cp.mauve,
  [''] = cp.mauve,
  V = cp.mauve,
  c = cp.peach,
  no = cp.red,
  s = cp.orange,
  S = cp.orange,
  [''] = cp.orange,
  ic = cp.yellow,
  R = cp.red,
  Rv = cp.violet,
  cv = cp.red,
  ce = cp.red,
  r = cp.red,
  rm = cp.red,
  ['r?'] = cp.cyan,
  ['!'] = cp.red,
  t = cp.red,
}

catppuccin.normal = {
  a = { bg = cp.blue, fg = cp.text, gui = 'bold' },
  b = { bg = cp.surface1, fg = cp.blue },
  -- c = { bg = config.transparent_background and 'NONE' or cp.mantle, fg = cp.text },
  c = { bg = cp.mantle, fg = cp.text },
}

catppuccin.insert = {
  a = { bg = cp.green, fg = cp.base, gui = 'bold' },
  b = { bg = cp.surface1, fg = cp.teal },
}

catppuccin.command = {
  a = { bg = cp.peach, fg = cp.base, gui = 'bold' },
  b = { bg = cp.surface1, fg = cp.peach },
}

catppuccin.visual = {
  a = { bg = cp.mauve, fg = cp.base, gui = 'bold' },
  b = { bg = cp.surface1, fg = cp.mauve },
}

catppuccin.replace = {
  a = { bg = cp.red, fg = cp.base, gui = 'bold' },
  b = { bg = cp.surface1, fg = cp.red },
}

catppuccin.inactive = {
  a = { bg = cp.mantle, fg = cp.blue },
  b = { bg = cp.mantle, fg = cp.surface1, gui = 'bold' },
  c = { bg = cp.mantle, fg = cp.overlay0 },
}

return catppuccin
