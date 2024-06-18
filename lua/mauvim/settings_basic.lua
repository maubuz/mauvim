-- TODO: Can I also use vim.o? How is vim.opt different from the later?
local opt = vim.opt

-- Most configurations inspired by chris@machine
-- See https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/options.lua

-- Mau, Jun 2024: See where shiftwidthand tabstop are set with:
-- :set tabstop? | set shiftwidth? | set softtabstop?
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = -1    -- When 'softtabstop' is negative, the value of 'shiftwidth' is used.

opt.number = true
opt.relativenumber = true
opt.hidden = true     -- Allow midified unsaved buffers to be hidden
opt.ignorecase = true                       -- ignore case in search patterns
opt.mouse = "a"                             -- allow the mouse to be used in neovim
opt.pumheight = 10                          -- pop up menu height
--opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
--opt.timeoutlen = 500                        -- time to wait for a mapped sequence to complete (in milliseconds)
opt.cursorline = true

-- Lexplore
--vim.g.netrw_browse_split = 2  -- open file in vertical split
--vim.g.netrw_winsize = 20
--vim.g.netrw_liststyle = 3

-- VimWiki
-- Unecessary due to defaults but basec on wimwiki's instructions (https://github.com/vimwiki/vimwiki)
-- vim.cmd allows the execution of vim script. See https://github.com/nanotee/nvim-lua-guide#vimcmd
-- vim.cmd('set nocompatible')
-- vim.cmd('filetype plugin on')
-- vim.cmd('syntax on')

-- Always open a buffer with all folds open
-- From https://bitcrowd.dev/folding-sections-of-markdown-in-vim
-- vim.cmd "set foldlevelstart=99"

