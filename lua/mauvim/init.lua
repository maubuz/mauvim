require 'mauvim.keymaps'
require 'mauvim.settings_basic'

-- Show special chars such as tab, space. Enable with :set list
vim.opt.listchars:append { eol = '↲', trail = '·', lead = '·' }
-- Other listchars options
-- vim.opt.listchars= {tab='🡢 ', tab = '▸ ', extends='>', precedes='<', space='·'}
