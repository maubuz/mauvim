require('render-markdown').setup {
  anti_conceal = { enabled = false },
  file_types = { 'markdown', 'opencode_output' },
}

vim.opt.autoread = true

require('opencode').setup {
  default_global_keymaps = false,
  ui = {
    picker_width = 0.9,
  },
  keymap = {
    input_window = {
      ['<S-Tab>'] = { 'switch_mode', mode = { 'n', 'i' }, desc = 'Switch agent mode', defer_to_completion = true },
    },
    editor = {
      ['<leader>it'] = { 'toggle', desc = 'Toggle OpenCode' },
      ['<leader>ia'] = { 'open_input', desc = 'Ask OpenCode' },
      ['<leader>i+'] = { 'add_visual_selection', mode = { 'v' }, desc = 'Add selection to context' },
      ['<leader>iY'] = { 'add_visual_selection_inline', mode = { 'v' }, desc = 'Insert selection inline into prompt' },
      ['<leader>is'] = { 'select_session', desc = 'Select session' },
      ['<leader>in'] = { 'open_input_new_session', desc = 'New session' },
      ['<leader>ii'] = { 'cancel', desc = 'Interrupt session' },
      ['<leader>id'] = { 'diff_open', desc = 'Review changes' },
    },
  },
}

vim.keymap.set('x', '<leader>ie', function()
  local first, last = vim.fn.line 'v', vim.fn.line '.'
  local api = require 'opencode.api'
  api.add_visual_selection({ open_input = false }, { start = math.min(first, last), stop = math.max(first, last) })
  api.run 'Explain the selected code and its context'
end, { desc = 'Explain selection' })
