return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()`, required for `toggle()` — otherwise optional
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
      provider = {
        --   enabled = 'terminal',
        --   terminal = {
        --     -- ...
        --   },
        enabled = 'snacks',
        snacks = {
          -- ...
        },
      },
    }

    -- Required for `vim.g.opencode_opts.auto_reload`
    vim.opt.autoread = true

    -- Recommended/example keymaps
    vim.keymap.set({ 'n', 'x' }, '<leader>ia', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask about this' })
    vim.keymap.set({ 'n', 'x' }, '<leader>i+', function()
      require('opencode').prompt '@this'
    end, { desc = 'Add this' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ie', function()
      require('opencode').prompt('Explain @this and its context', { submit = true })
    end, { desc = 'Explain this' })
    vim.keymap.set({ 'n', 'x' }, '<leader>is', function()
      require('opencode').select()
    end, { desc = 'Select prompt' })
    vim.keymap.set('n', '<leader>it', function()
      require('opencode').toggle()
    end, { desc = 'Toggle embedded' })
    vim.keymap.set('n', '<leader>in', function()
      require('opencode').command 'session_new'
    end, { desc = 'New session' })
    vim.keymap.set('n', '<leader>ii', function()
      require('opencode').command 'session_interrupt'
    end, { desc = 'Interrupt session' })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'messages_half_page_up'
    end, { desc = 'Messages half page up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'messages_half_page_down'
    end, { desc = 'Messages half page down' })
  end,
}
