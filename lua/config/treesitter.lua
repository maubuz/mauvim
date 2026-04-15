-- nvim-treesitter main-branch API: old ensure_installed/auto_install/highlight/indent fields are silently ignored
local languages = {
  'bash',
  'c',
  'diff',
  'html',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
}

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if not lang then return end
    local ok = pcall(vim.treesitter.start, ev.buf, lang)
    if not ok then return end
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- Window-local fold opts ensure folding works in external editors (e.g. Posting)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    -- Recompute folds after treesitter parses; without this, folds cached before parser start are stale
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        vim.cmd.normal { 'zx', bang = true }
      end
    end)
  end,
})
