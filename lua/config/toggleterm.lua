require('toggleterm').setup {
  open_mapping = [[<c-\>]],
}

vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=vertical size=' .. math.floor(vim.o.columns * 0.5) .. '<cr>', { desc = '[T]oggle [T]erminal vertical' })
vim.keymap.set('v', '<leader>tv', function()
  require('toggleterm').send_lines_to_terminal('visual_lines', true, { args = vim.v.count })
end, { desc = 'Send [v]isual lines to terminal' })

-- Pass C-l to terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*toggleterm#*',
  callback = function()
    vim.keymap.set('t', '<C-l>', '<C-l>', { buffer = true })
  end,
})
