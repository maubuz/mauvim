-- [[ Plugin management via native vim.pack (0.12) ]]

local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add({
  -- Colorscheme
  gh 'folke/tokyonight.nvim',

  -- Core tools
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-fzf-native.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'folke/which-key.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'nvim-treesitter/nvim-treesitter',

  -- Formatting & linting
  gh 'stevearc/conform.nvim',
  gh 'mfussenegger/nvim-lint',

  -- Editor enhancements
  gh 'echasnovski/mini.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
  { src = 'https://codeberg.org/andyg/leap.nvim' },
  gh 'tpope/vim-sleuth',

  -- File management
  gh 'nvim-neo-tree/neo-tree.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'stevearc/oil.nvim',
  gh 'echasnovski/mini.icons',

  -- AI & coding
  gh 'github/copilot.vim',
  gh 'olimorris/codecompanion.nvim',
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'NickvanDyke/opencode.nvim',
  gh 'folke/snacks.nvim',

  -- Terminal & debugging
  gh 'akinsho/toggleterm.nvim',
  gh 'mfussenegger/nvim-dap',
  gh 'rcarriga/nvim-dap-ui',
  gh 'nvim-neotest/nvim-nio',

  -- LSP tooling (install only, not for LSP config)
  gh 'williamboman/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'folke/lazydev.nvim',
  gh 'Bilal2453/luvit-meta',

  -- Diff
  gh 'sindrets/diffview.nvim',
}, { load = true })

-- Build steps via PackChanged autocmd
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local name = ev.data.spec.name
    if name == 'telescope-fzf-native.nvim' and ev.data.kind ~= 'delete' then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
    if name == 'nvim-treesitter' and ev.data.kind ~= 'delete' then
      vim.cmd 'TSUpdate'
    end
  end,
})
