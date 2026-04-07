require('tokyonight').setup {
  style = 'night',
  on_highlights = function(hl, _)
    hl.Comment = { fg = hl.Comment.fg, italic = false }
  end,
}
vim.cmd.colorscheme 'tokyonight-night'
