-- copilot.vim loads automatically, no setup needed
-- Disable for certain filetypes if needed:
-- vim.g.copilot_filetypes = { ['*'] = true }

-- Disable inline ghost text by default.
-- Copilot suggestions are still available as completion items in the popup
-- menu via copilot-language-server (native LSP, see lsp.lua).
vim.g.copilot_enabled = 0

-- Toggle inline ghost text on/off when needed
vim.keymap.set('n', '<leader>ct', function()
  vim.g.copilot_enabled = vim.g.copilot_enabled == 0 and 1 or 0
end, { desc = 'Toggle Copilot inline suggestion' })


