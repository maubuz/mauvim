# newvim — Neovim 0.12 Native Configuration

A minimal neovim config built on top of neovim 0.12's native features, migrated from a kickstart.nvim fork. The design principle: use built-in functionality first, add plugins only where native features are insufficient.

Run with: `NVIM_APPNAME=newvim nvim`

## Architecture

```
~/.config/newvim/
  init.lua                          -- Entry point: leader keys, require order
  .stylua.toml                      -- Lua formatter: 2-space indent, 160 col, single quotes
  lua/
    options.lua                     -- All vim.opt settings (merged kickstart + personal)
    keymaps.lua                     -- Only keymaps NOT in 0.12 defaults
    clipboard.lua                   -- SSH OSC 52 paste override
    pack.lua                        -- vim.pack.add() plugin list + build hooks
    lsp.lua                         -- Native LSP config, completion, document highlight
    config/                         -- One file per plugin (setup + keymaps)
      telescope.lua                 -- Fuzzy finder (<leader>s* keymaps)
      gitsigns.lua                  -- Git gutter + hunk actions (<leader>h*)
      which-key.lua                 -- Keymap hint groups
      treesitter.lua                -- Parser install + highlight/indent
      conform.lua                   -- Formatters by filetype (<leader>f)
      lint.lua                      -- nvim-lint for markdown (<leader>tl toggle)
      tokyonight.lua                -- Colorscheme (night, no italic comments)
      todo-comments.lua             -- TODO/FIXME highlighting
      mini.lua                      -- mini.ai (textobjects) + mini.surround (z-prefix)
      neo-tree.lua                  -- File tree (\ toggle, <leader>e)
      oil.lua                       -- Buffer file manager (<leader>o, <leader>l float)
      leap.lua                      -- Motion plugin (s/S/gs)
      copilot.lua                   -- GitHub Copilot (auto-loads)
      toggleterm.lua                -- Terminal (<C-\>, <leader>tt, <leader>tv)
      dap.lua                       -- Debug adapter (F1-F7, <leader>b)
      codecompanion.lua             -- AI chat via copilot (<leader>a, <leader>tc)
      snacks.lua                    -- snacks.nvim setup (input enabled, opencode dependency)
      opencode.lua                  -- Opencode integration (<leader>i*)
      indent-blankline.lua          -- Indent guides (<leader>ti toggle)
      diffview.lua                  -- Git diff viewer
      mason.lua                     -- Binary installer (LSP servers, formatters, linters)
```

## First launch notes

  On first run, vim.pack will clone all plugins (parallel git). After that:
  1. Run :MasonToolsInstall to install LSP servers and tools
  2. Run :TSUpdate to install treesitter parsers
  3. Build telescope-fzf-native: the PackChanged autocmd handles this, but if needed manually run make in the plugin directory


## Key Design Decisions

### Native features replacing plugins (0.12)

| What | Native replacement | Was |
|------|-------------------|-----|
| LSP config | `vim.lsp.config()` + `vim.lsp.enable()` | nvim-lspconfig |
| Completion | `vim.lsp.completion.enable()` with autotrigger | nvim-cmp + LuaSnip + sources |
| Plugin manager | `vim.pack.add()` | lazy.nvim |
| Folding | `vim.treesitter.foldexpr()` | nvim-ufo |
| Statusline | Built-in (diagnostics + LSP progress) | mini.statusline + fidget.nvim |
| Undo tree | `:Undotree` command | jiaoshijie/undotree |
| Word highlight | `document_highlight` autocmd in lsp.lua | vim-illuminate |

### Keymaps omitted (now 0.12 defaults)

These are built into neovim 0.12 and do NOT need configuration:
- `Esc` clears hlsearch
- `K` hover, `grn` rename, `grr` references, `gri` implementation, `gra` code action, `gO` document symbols
- `[d`/`]d` diagnostic navigation, `[q`/`]q` quickfix, `[b`/`]b` buffer navigation
- `Tab`/`S-Tab` snippet jump, `C-S` signature help
- OSC 52 clipboard copy (paste still needs clipboard.lua for SSH)

## How Things Connect

### Startup flow

`init.lua` → options → keymaps → clipboard → **pack.lua** (installs/loads all plugins) → config/*.lua (configures each plugin) → **lsp.lua** (must be last, depends on telescope + lazydev)

### LSP pipeline

1. **mason.lua** installs binaries (LSP servers, formatters, linters)
2. **lsp.lua** configures servers via `vim.lsp.config[]` and enables them with `vim.lsp.enable()`
3. On `LspAttach`: sets up telescope-powered goto keymaps, completion, document highlight, inlay hints
4. **conform.lua** handles formatting (separate from LSP)
5. **lint.lua** handles linting (separate from LSP)

### Plugin management (vim.pack)

- All plugins listed in `pack.lua` via `vim.pack.add(specs, { load = true })`
- **Important**: `load = true` is required — during init.lua, vim.pack defaults to `load = false` (install only, no `:packadd`), which means `require()` calls in config files would fail
- Plugins install on first launch (parallel git clone)
- Lockfile: `nvim-pack-lock.json` (version-controllable)
- Build steps use `PackChanged` autocmd (telescope-fzf-native `make`, treesitter `TSUpdate`)
- Update plugins: `:lua vim.pack.update()`

## Common Tasks

### Add a new plugin

1. Add the URL to `vim.pack.add()` in `lua/pack.lua`
2. Create `lua/config/<name>.lua` with `require('<plugin>').setup { ... }` and keymaps
3. Add `require 'config.<name>'` to `init.lua` (order matters if it depends on other plugins)

**Note**: Most plugins use `require('<name>').setup {}`. Exceptions exist — e.g. `opencode.nvim` uses `vim.g.opencode_opts` and `copilot.vim` auto-loads with no setup call. Always check the plugin's docs.

### Add a new LSP server

1. Add the mason package name to `ensure_installed` in `lua/config/mason.lua`
2. Add `vim.lsp.config['server_name'] = { cmd, filetypes, root_markers, settings }` in `lua/lsp.lua`
3. Add the name to the `vim.lsp.enable()` call

### Add a new formatter

Edit `lua/config/conform.lua`: add the filetype → formatter mapping to `formatters_by_ft`, and any custom args to `formatters`.

### Add a new linter

Edit `lua/config/lint.lua`: add the filetype → linter mapping to `linters_by_ft`.

### Swap native completion back to nvim-cmp

Only `lua/lsp.lua` needs modification — remove the `vim.lsp.completion.enable()` call in the `LspAttach` autocmd and configure nvim-cmp instead. The 0.12 native completion is new; this isolation is intentional.

## Gotchas

- **`vim.pack.add()` needs `{ load = true }`** during init.lua — otherwise plugins are only installed, not loaded
- **`nvim-treesitter`** module is `nvim-treesitter.config` (singular), not `nvim-treesitter.configs` (the old name)
- **`opencode.nvim`** has no `setup()` — configure via `vim.g.opencode_opts`, keymaps call `require('opencode')` functions directly
- **`snacks.nvim`** must be set up before `opencode.nvim` (provides enhanced input UI)
- **LSP keymaps `gd`, `grr`, `gri`** are overridden in `lsp.lua` to use Telescope — the native 0.12 defaults still exist as fallback if Telescope is removed

## Configured LSP Servers

| Server | Language | Formatter | Linter |
|--------|----------|-----------|--------|
| lua_ls | Lua | stylua | — |
| ruff | Python | (ruff built-in) | — |
| terraformls | Terraform/HCL | terraform_fmt | — |
| bashls | Bash/Shell | shfmt | shellcheck |
| jsonls | JSON/JSONC | — | — |
| — | Markdown | cbfmt, markdownlint | markdownlint |
| — | YAML | yamlfmt | — |
