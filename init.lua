-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Core config ]]
require 'options'
require 'keymaps'
require 'clipboard'

-- [[ Plugin management (native vim.pack) ]]
require 'pack'

-- [[ Plugin configs ]]
require 'config.tokyonight'
require 'config.telescope'
require 'config.gitsigns'
require 'config.which-key'
require 'config.treesitter'
require 'config.conform'
require 'config.lint'
require 'config.todo-comments'
require 'config.mini'
require 'config.neo-tree'
require 'config.oil'
require 'config.leap'
require 'config.copilot'
require 'config.toggleterm'
require 'config.dap'
require 'config.sidekick'
require 'config.snacks'
require 'config.opencode'
require 'config.indent-blankline'
require 'config.diffview'
require 'config.mason'

-- [[ Native LSP + completion (after plugins are loaded) ]]
require 'lsp'
