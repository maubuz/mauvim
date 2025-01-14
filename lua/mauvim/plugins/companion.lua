return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  strategies = {
    chat = {
      adapter = 'copilot',
    },
    inline = {
      adapter = 'copilot',
    },
  },
  opts = {},
  keys = {
    { '<leader>a', '<cmd>CodeCompanionActions<cr>', mode = 'n', desc = 'CodeCompanion Actions', noremap = true, silent = true },
    { '<leader>a', '<cmd>CodeCompanionActions<cr>', mode = 'v', desc = 'CodeCompanion Actions', noremap = true, silent = true },
    { '<leader>tc', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'n', desc = 'CodeCompanion Chat', noremap = true, silent = true },
    { '<leader>tc', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'v', desc = 'CodeCompanion Chat', noremap = true, silent = true },
    { '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'CodeCompanion Add Chat', noremap = true, silent = true },
  },
  init = function()
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
