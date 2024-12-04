-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end,
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure {
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
      }
    end,
  },
  -- Mau, Nov 2024: Remove nvim-surround, not working as expected most of the time
  -- {
  --   'kylechui/nvim-surround',
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = function()
  --     require('nvim-surround').setup {
  --       -- Modify keymaps to avoid conflict with leap.nvim plugin (Mau Apr 21, 2024)
  --       -- See discussion https://github.com/ggandor/leap.nvim/discussions/59
  --       -- and https://github.com/ggandor/leap.nvim/issues/182
  --       keymaps = {
  --         insert = '<C-g>z',
  --         insert_line = '<C-g>Z',
  --         normal = 'yz',
  --         normal_cur = 'yzz',
  --         normal_line = 'yZ',
  --         normal_cur_line = 'yZZ',
  --         visual = 'Z',
  --         visual_line = 'gZ',
  --         delete = 'dz',
  --         change = 'cz',
  --         change_line = 'cZ',
  --       },
  --     }
  --   end,
  -- },
}
