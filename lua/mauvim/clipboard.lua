-- Description: Configure clipboard to use OSC 52 when in an SSH session
-- Ref: https://github.com/neovim/neovim/discussions/28010#discussioncomment-10719238

local function paste()
  return {
    vim.split(vim.fn.getreg '', '\n'),
    vim.fn.getregtype '',
  }
end

-- print('SSH_TTY:', vim.env.SSH_TTY)
-- print('WEZTERM_EXECUTABLE:', vim.env.WEZTERM_EXECUTABLE)

if vim.env.SSH_TTY or vim.env.WEZTERM_EXECUTABLE then
  -- print('Setting OSC 52 clipboard')
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end
