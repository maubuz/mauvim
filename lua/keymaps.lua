-- [[ Keymaps ]]
-- Only keymaps NOT provided by neovim 0.12 defaults.
-- 0.12 defaults include: Esc clears hlsearch, TextYankPost highlight,
-- LSP keymaps (K, grn, grr, gri, grt, grx, gra, gO, C-S sig help),
-- diagnostic nav ([d/]d, [D/]D), list nav ([q/]q, [b/]b),
-- snippet Tab/S-Tab navigation.

local map = vim.keymap.set

-- Save with Ctrl-S
map({ 'n', 'i' }, '<C-S>', '<cmd>update<cr>', { desc = 'Save file' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Terminal window navigation
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Move focus to the left window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Move focus to the lower window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Move focus to the upper window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Move focus to the right window' })

-- Diagnostic loclist
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Resize windows with Ctrl+Arrow
map('n', '<C-Up>', ':resize -2<cr>', { desc = 'Resize window up' })
map('n', '<C-Down>', ':resize +2<cr>', { desc = 'Resize window down' })
map('n', '<C-Left>', ':vertical resize -2<cr>', { desc = 'Resize window left' })
map('n', '<C-Right>', ':vertical resize +2<cr>', { desc = 'Resize window right' })

-- Buffer navigation
map('n', '<S-l>', ':bnext<cr>', { desc = 'Next buffer' })
map('n', '<S-h>', ':bprevious<cr>', { desc = 'Previous buffer' })

-- Move text up and down
map('n', '<A-Down>', ':m .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-Up>', ':m .-2<cr>==', { desc = 'Move line up' })
map('v', '<A-Down>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<A-Up>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })
map('x', '<A-Down>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('x', '<A-Up>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Select all
map('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Stay in indent mode (visual)
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Paste without yanking replaced text (visual)
map('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- Undotree (native 0.12)
map('n', '<leader>u', '<cmd>Undotree<cr>', { desc = '[U]ndotree' })
