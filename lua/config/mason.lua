require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server',
    'ruff',
    'terraform-ls',
    'bash-language-server',
    'json-lsp',
    'markdownlint',
    'stylua',
    'shfmt',
    'shellcheck',
    'yaml-language-server',
    'yamlfmt',
    'bash-debug-adapter',
    'tree-sitter-cli', -- required by nvim-treesitter main-branch to compile parsers
  },
}
