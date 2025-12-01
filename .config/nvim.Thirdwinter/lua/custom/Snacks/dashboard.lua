local function getGreeting()
  local tableTime = os.date '*t'
  local datetime = os.date ' %Y-%m-%d-%A   %H:%M:%S '
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = '  Sleep well',
    [2] = '  Good morning',
    [3] = '  Good afternoon',
    [4] = '  Good evening',
    [5] = '󰖔  Good night',
  }
  local greetingIndex = 0
  if hour == 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 21 then
    greetingIndex = 4
  elseif hour >= 21 then
    greetingIndex = 5
  end
  return datetime .. '  ' .. greetingsTable[greetingIndex] .. ', ' .. vim.g.Username
end

return {
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find file', action = ':lua Snacks.picker.smart()' },
      { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = ' ', key = 'n', desc = 'Neovim Settings', action = ":lua Snacks.picker.smart { cwd = vim.fn.stdpath 'config' }" },
      {
        icon = ' ',
        key = 'l',
        desc = 'Load Session',
        action = function()
          require('custom.resession').load_last()
          vim.cmd 'filetype detect'
        end,
      },
      { icon = ' ', key = 'u', desc = 'Update plugins', action = ':Lazy update' },
      -- { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    -- Used by the `header` section
    -- header = require('custom.logo').bianxingjinggang,
    -- header = require('custom.logo').newyear,
    -- header = require('custom.logo').Miku,
    header = require('custom.logo').miku,
    -- header = require('custom.logo').cute,
    -- header = require('custom.logo').lovely,
    -- header = require('custom.logo').wenwen,
    -- header = require('custom.logo').touhou,
    -- header = require('custom.logo').menggirl,
    -- header = require('custom.logo').beautiful,
    -- header = require('custom.logo').keai,
    -- header = require('custom.logo').girl,
    -- header = require('custom.logo').linboli,
    -- header = require('custom.logo').loli,
    -- header = require('custom.logo').longnvpu,
    -- header = require('custom.logo').cool_02,
    -- header = require('custom.logo').papijiang,
    -- header = require('custom.logo').pacman,
    -- header = require('custom.logo').free,
    -- header = require('custom.logo').panda,
    -- header = require('custom.logo').cat,
    -- header = require('custom.logo').pikaqiu,
    -- header = require('custom.logo').nvim2,
    -- header = require('custom.logo').nvim3,
    -- header = require('custom.logo').doom,
    -- header = require('custom.logo').ball,
    -- header = require('custom.logo').logo1,
    -- header = require('custom.logo').logo3,
    -- header = require('custom.logo').A1,
    -- header = require('custom.logo').planet1,
    -- header = require('custom.logo').planet2,
    -- header = require('custom.logo').earth,
    -- header = require('custom.logo').outer_wilds,
    -- header = require('custom.logo').bb_boy,
    -- header = require('custom.logo').bat,
    -- header = require('custom.logo').nvim,
    -- header = require('custom.logo').nvim6,
  },
  -- item field formatters
  sections = {
    { section = 'header' },
    { section = 'keys',                                    gap = 1, padding = 1 },
    { text = '\n' },
    { text = { getGreeting(), hl = 'SnacksDashboardDesc' } },
    { section = 'startup' },
  },
}
