local lint = require 'lint'

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}

-- Override markdownlint to disable MD013 (line length)
lint.linters.markdownlint.args = {
  '--disable', 'MD013', '--',
}

local lint_enabled = true
vim.keymap.set('n', '<leader>tl', function()
  lint_enabled = not lint_enabled
  if not lint_enabled then
    vim.diagnostic.reset()
  end
  vim.notify('Linting ' .. (lint_enabled and 'enabled' or 'disabled'))
end, { desc = '[T]oggle [L]int' })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('newvim-lint', { clear = true }),
  callback = function()
    if lint_enabled then
      lint.try_lint()
    end
  end,
})
