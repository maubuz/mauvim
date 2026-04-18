-- [[ Native LSP configuration (0.11+) ]]
-- Replaces nvim-lspconfig, nvim-cmp, fidget.nvim, vim-illuminate

-- Configure lazydev for Lua LSP (must be before lsp.config)
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- [[ LSP server configurations ]]

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

vim.lsp.config['ruff'] = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
}

vim.lsp.config['terraformls'] = {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars', 'hcl' },
  root_markers = { '.terraform', '.git' },
}

vim.lsp.config['bashls'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
}

vim.lsp.config['jsonls'] = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
}

-- Copilot LSP (github/copilot-language-server-release)
-- Required by sidekick.nvim for Next Edit Suggestions (NES).
-- sidekick.nvim needs copilot registered via vim.lsp.config + vim.lsp.enable
-- (copilot.vim alone starts its own internal client that sidekick can't discover).
-- Installed automatically via Mason (see config/mason.lua ensure_installed).
vim.lsp.config['copilot'] = {
  cmd = { 'copilot-language-server', '--stdio' },
  root_markers = { '.git' },
  init_options = {
    editorInfo = { name = 'Neovim', version = tostring(vim.version()) },
    editorPluginInfo = { name = 'Neovim', version = tostring(vim.version()) },
  },
  -- GitHub device-flow auth commands (:LspCopilotSignIn / :LspCopilotSignOut).
  -- Adapted from nvim-lspconfig's lsp/copilot.lua — needed because we configure
  -- the LSP server directly instead of through nvim-lspconfig.
  -- The copilot-language-server exposes custom 'signIn'/'signOut' LSP requests
  -- that trigger GitHub's OAuth device flow (copy code → open browser → confirm).
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignIn', function()
      client:request('signIn', vim.empty_dict(), function(err, result)
        if err then
          vim.notify(err.message, vim.log.levels.ERROR)
          return
        end
        if result.command then
          vim.fn.setreg('+', result.userCode)
          vim.fn.setreg('*', result.userCode)
          local ok = vim.fn.confirm(
            'Copied your one-time code to clipboard.\nOpen the browser to complete sign-in?',
            '&Yes\n&No'
          )
          if ok == 1 then
            client:exec_cmd(result.command, { bufnr = bufnr }, function(cmd_err, cmd_result)
              if cmd_err then
                vim.notify(cmd_err.message, vim.log.levels.ERROR)
                return
              end
              if cmd_result.status == 'OK' then
                vim.notify('Signed in as ' .. cmd_result.user .. '.')
              end
            end)
          end
        elseif result.status == 'AlreadySignedIn' then
          vim.notify('Already signed in as ' .. result.user .. '.')
        end
      end)
    end, { desc = 'Sign in to Copilot' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignOut', function()
      client:request('signOut', vim.empty_dict(), function(err, result)
        if err then
          vim.notify(err.message, vim.log.levels.ERROR)
          return
        end
        if result.status == 'NotSignedIn' then
          vim.notify('Not signed in.')
        end
      end)
    end, { desc = 'Sign out of Copilot' })
  end,
}

-- Enable all configured servers
vim.lsp.enable { 'lua_ls', 'ruff', 'terraformls', 'bashls', 'jsonls', 'copilot' }

-- [[ LspAttach autocmd ]]
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('newvim-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    -- Telescope-powered overrides for better UI
    local builtin = require 'telescope.builtin'
    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('grr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Aliases for muscle memory
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    -- Declaration
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Toggle inlay hints
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf })
      end, '[T]oggle Inlay [H]ints')
    end

    -- Document highlight on CursorHold (replaces vim-illuminate)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('newvim-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('newvim-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'newvim-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Native completion (0.12)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, buf) then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end
  end,
})
