return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      git = {
        -- Return true to automatically git add/mv/rm files
        mv = function(src_path, dest_path)
          return true
        end,
      },
      keymaps = {
        ['<c-u>'] = {
          'actions.preview_scroll_up',
          desc = 'Scroll up preview',
        },
        ['<c-d>'] = {
          'actions.preview_scroll_down',
          desc = 'Scroll down preview',
        },
      },
    },
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  -- Close Oil anytime with <C-c>
  vim.keymap.set('n', '<leader>o', ':Oil<CR>', { desc = 'Oil: open' }),
  vim.keymap.set('n', '<leader>l', function()
    require('oil').toggle_float()
  end, { desc = 'Oil: toggle float' }),
}
