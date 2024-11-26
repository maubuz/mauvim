-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  --     {
  --     'glacambre/firenvim',
  --
  --     -- Lazy load firenvim
  --     -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --     lazy = not vim.g.started_by_firenvim,
  --     build = function()
  --         vim.fn["firenvim#install"](0)
  --     end
  -- },

  -- Mau, Nov 2024: Remove nvim-surround, not working as expected most of the time
  -- {
  --   'kylechui/nvim-surround',
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = function()
  --     require('nvim-surround').setup {
  --       -- Modify keymaps to avoid conflict with leap.nvim plugin (Mau Apr 21, 2024)
  --       -- See discussion https://github.com/ggandor/leap.nvim/discussions/59
  --       -- and https://github.com/ggandor/leap.nvim/issues/182
  --       keymaps = {
  --         insert = '<C-g>z',
  --         insert_line = '<C-g>Z',
  --         normal = 'yz',
  --         normal_cur = 'yzz',
  --         normal_line = 'yZ',
  --         normal_cur_line = 'yZZ',
  --         visual = 'Z',
  --         visual_line = 'gZ',
  --         delete = 'dz',
  --         change = 'cz',
  --         change_line = 'cZ',
  --       },
  --     }
  --   end,
  -- },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end,
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure {
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
      }
    end,
  },
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   branch = 'v3.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --   },
  --   -- Mau, May 21, 2024: Open folders with neo-tree instead of newtr
  --   -- Code taken from https://www.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
  --   cmd = 'Neotree',
  --   init = function()
  --     vim.api.nvim_create_autocmd('BufEnter', {
  --       -- make a group to be able to delete it later
  --       group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
  --       callback = function()
  --         local f = vim.fn.expand '%:p'
  --         if vim.fn.isdirectory(f) ~= 0 then
  --           vim.cmd('Neotree current dir=' .. f)
  --           -- neo-tree is loaded now, delete the init autocmd
  --           vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
  --         end
  --       end,
  --     })
  --     -- keymaps
  --   end,
  --   opts = {
  --     filesystem = {
  --       hijack_netrw_behavior = 'open_current',
  --     },
  --   },
  -- },
  -- {
  --     "nvimtools/none-ls.nvim",
  --     config = function()
  --         local null_ls = require("null-ls")
  --
  --         null_ls.setup({
  --             sources = {
  --                 null_ls.builtins.formatting.stylua,
  --                 null_ls.builtins.completion.spell,
  --                 -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
  --                 null_ls.builtins.formatting.cbfmt,
  --             },
  --         })
  --     end
  -- }
  {
    -- Mau, Aug 28, 2024: disabled here in favour of the Kickstart configuration
    -- "stevearc/conform.nvim",
    -- lazy = false,
    -- event = { "BufWritePre", "BufReadPre" },
    -- cmd = { "ConformInfo" },
    -- keys = {
    --     {
    --         -- Customize or remove this keymap to your liking
    --         "<leader>f",
    --         function()
    --             require("conform").format({ async = true, lsp_fallback = false })
    --         end,
    --         mode = "",
    --         desc = "Format buffer",
    --     },
    -- },
    -- config = function()
    --     local conform = require("conform")
    --     conform.setup({
    --         formatters_by_ft = {
    --             sh = { "shfmt" },
    --             bash = { "shfmt" },
    --         }
    --     })
    --     conform.formatters.shfmt = {
    --         prepend_args = { "-i", "4", "-ci", "-bn" }
    --     }
    -- end,
    -- Everything in opts will be passed to setup()
    -- opts = {
    --     -- Define your formatters
    --     formatters_by_ft = {
    --         lua = { "stylua" },
    --         -- python = { "isort", "black" },
    --         -- javascript = { { "prettierd", "prettier" } },
    --         markdown = { "cbfmt" },
    --     },
    --     -- Set up format-on-save
    --     -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    --     -- Customize formatters
    --     formatters = {
    --         shfmt = {
    --             prepend_args = { "-i", "4" },
    --         },
    --     },
    -- },
    -- init = function()
    --     -- If you want the formatexpr, here is the place to set it
    --     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  },
  -- {
  --     'glacambre/firenvim',
  --
  --     -- Lazy load firenvim
  --     -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --     lazy = not vim.g.started_by_firenvim,
  --     build = function()
  --         vim.fn["firenvim#install"](0)
  --     end
  -- },
  -- {
  --     -- Mau, Jun 2024: Install otter to run lsp feastures in
  --     -- code blocks (embedded code) inside Markdown
  --     'jmbuhr/otter.nvim',
  --     config = function()
  --         local otter = require'otter'
  --             vim.api.nvim_create_autocmd('BufEnter', {
  --                 -- make a group to be able to delete it later
  --                 group = vim.api.nvim_create_augroup('OtterInit', { clear = true }),
  --                 callback = function()
  --                     -- table of embedded languages to look for.
  --                     -- default = nil, which will activate
  --                     -- any embedded languages found
  --                     -- local languages = {'python', 'lua' }
  --                     local languages = {'bash', 'sh' }
  --
  --                     -- enable completion/diagnostics
  --                     -- defaults are true
  --                     local completion = true
  --                     local diagnostics = true
  --                     -- treesitter query to look for embedded languages
  --                     -- uses injections if nil or not set
  --                     local tsquery = nil
  --
  --                     otter.activate(languages, completion, diagnostics, tsquery)
  --                 end
  --             })
  --             -- keymaps
  --         end
  -- }
}
