-- mini.ai: Better Around/Inside textobjects
require('mini.ai').setup { n_lines = 500 }

-- mini.surround: Add/delete/replace surroundings (brackets, quotes, etc.)
-- Uses z-prefix to avoid conflicts
require('mini.surround').setup {
  mappings = {
    add = 'za',
    delete = 'zd',
    find = 'zf',
    find_left = 'zF',
    highlight = 'zh',
    replace = 'zr',
    update_n_lines = 'zn',
  },
}
