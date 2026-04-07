---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.config').setup {
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { 'ruby' },
  },
}
