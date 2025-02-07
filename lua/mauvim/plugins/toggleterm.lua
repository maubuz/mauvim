return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      --[[ things you want to change go here]]
      open_mapping = [[<c-\>]],
    },
    keys = {
      {
        '<leader>tt',
        function()
          local width = vim.api.nvim_win_get_width(0) / 2
          vim.cmd('ToggleTerm size=' .. width .. ' direction=vertical')
        end,
        desc = 'Toggle terminal vertically half-width',
      },
      {
        '<leader>tv',
        function()
          vim.cmd 'ToggleTermSendVisualLines'
          -- vim.cmd('require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })'),
        end,
        mode = { 'n', 'v' },
        desc = 'Execute lines in terminal',
      },
      {
        '<C-l>',
        'clear<cr>',
        -- '<C-\\><C-N><C-l>',
        mode = { 't' },
        desc = 'Pass CTRL-L to terminal',
      },
    },
  },
}
