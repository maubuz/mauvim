return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = {
      --     c = true,
      --     cpp = true,
      --     markdown = true,
      --     md = true,
      --     yaml = true,
      --     yml = true,
      --   }
      --   return {
      --     timeout_ms = 500,
      --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- markdown = { 'cbfmt', 'markdownlint-cli2' },
        markdown = { 'cbfmt', 'markdownlint' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        yaml = { 'yamlfmt' },
        terraform = { 'terraform_fmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '4', '-ci', '-bn' },
        },
        yamlfix = {
          -- Ref: https://unix.stackexchange.com/questions/765360/yamlfix-not-using-configuration-neovim-usage
          env = {
            -- YAMLFIX_EXPLICIT_START = false,
          },
        },
        markdownlint = {
          prepend_args = { '--disable', 'MD013' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
