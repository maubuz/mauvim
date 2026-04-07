require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    markdown = { 'cbfmt', 'markdownlint' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    yaml = { 'yamlfmt' },
    terraform = { 'terraform_fmt' },
  },
  formatters = {
    shfmt = {
      prepend_args = { '-i', '4', '-ci', '-bn' },
    },
    markdownlint = {
      prepend_args = { '--disable', 'MD013' },
    },
    yamlfmt = {
      prepend_args = { '-formatter', 'indent=4,include_document_start=true' },
    },
  },
}

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })
