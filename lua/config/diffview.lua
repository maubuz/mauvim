require('diffview').setup {}

-- Two-step Telescope branch picker → DiffviewOpen base..compare
local function diffview_branch_diff()
  local builtin = require 'telescope.builtin'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  builtin.git_branches {
    prompt_title = '(1/2) Base branch',
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        local base = action_state.get_selected_entry().name
        actions.close(bufnr)

        builtin.git_branches {
          prompt_title = '(2/2) Compare branch  [base: ' .. base .. ']',
          attach_mappings = function(bufnr2)
            actions.select_default:replace(function()
              local compare = action_state.get_selected_entry().name
              actions.close(bufnr2)
              vim.cmd('DiffviewOpen ' .. base .. '..' .. compare)
            end)
            return true
          end,
        }
      end)
      return true
    end,
  }
end

vim.keymap.set('n', '<leader>gD', diffview_branch_diff, { desc = '[g]it [D]iff two branches' })
