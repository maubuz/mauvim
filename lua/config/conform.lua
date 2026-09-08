require('conform').setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    markdown = { 'cbfmt', 'markdownlint' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    yaml = { 'yamlfmt' },
    terraform = { 'terraform_fmt' },
    -- Prefer LSP (jsonls) if attached; fall back to jq for unnamed buffers / CLI-piped text
    -- LSP (jsonls) requires a project root/file on disk to attach, so lsp_fallback fails
    -- on unnamed buffers and text piped directly from the CLI. jq formats via stdin directly.
    json = { 'jq', lsp_format = 'prefer' },
    jsonc = { 'jq', lsp_format = 'prefer' },
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
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
