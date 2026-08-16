# Plan: Copilot in popup menu + native inline ghost text

## Context

Today this Neovim 0.12 config uses `vim.lsp.completion.enable()` (native) for the popup menu and `copilot.vim` for inline ghost text (currently disabled via `vim.g.copilot_enabled = 0`). `copilot-language-server` is attached for `sidekick.nvim` NES.

Copilot suggestions never reach the popup menu because `copilot-language-server` **does not implement `textDocument/completion`** — it only implements `textDocument/inlineCompletion` (LSP 3.18) plus custom methods. Native 0.12 completion only queries the standard `textDocument/completion` method, so there is nothing for it to surface.

Chosen direction is **both paths**:
1. **Popup items**: migrate the completion engine from native `vim.lsp.completion` → `blink.cmp`, and add `fang2hou/blink-copilot` so Copilot appears as popup items alongside LSP, path, snippet, buffer sources.
2. **Inline ghost text**: replace `copilot.vim` with Neovim 0.12's native `vim.lsp.inline_completion.enable()`, driven by the already-registered `copilot-language-server`. Fewer plugins, same UX.

`sidekick.nvim` and its NES keymaps stay as-is.

## Changes

### 1. `lua/pack.lua`
- **Add**:
  - `saghen/blink.cmp` — release tag `v1.*` recommended so you get the prebuilt Rust fuzzy-matcher binary (no `cargo build` needed). `vim.pack.add` does not support version tags directly; use `{ src = gh 'saghen/blink.cmp', version = 'v1.*' }` syntax if supported, otherwise track `main` and accept the fuzzy-matcher fallback to Lua. Verify `:lua =vim.pack.add` signature in your 0.12 build.
  - `fang2hou/blink-copilot`
  - `rafamadriz/friendly-snippets` (optional but standard snippet pack for the `snippets` source)
- **Remove**: `github/copilot.vim` (no longer used — native `vim.lsp.inline_completion` replaces it)

### 2. `lua/lsp.lua`
- **Remove** the `vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })` block (lines 176-178). blink.cmp owns the popup now.
- **Add**, once after `vim.lsp.enable {...}` (line 114):
  ```lua
  vim.lsp.inline_completion.enable()
  ```
  This is global, applies to any LSP advertising `textDocument/inlineCompletion` (copilot-language-server).

### 3. `lua/config/copilot.lua` → rename/repurpose
Current file only controls `vim.g.copilot_enabled` for `copilot.vim`. After removing `copilot.vim`, repurpose it for the native inline-completion toggle and accept keymap:

```lua
-- Accept inline completion with <C-l> (keeps <Tab> free for snippet placeholder jumps)
vim.keymap.set('i', '<C-l>', function()
  if not vim.lsp.inline_completion.get() then
    return '<C-l>'
  end
end, { expr = true, desc = 'Accept Copilot inline completion' })

-- Cycle inline completion candidates
vim.keymap.set('i', '<M-]>', function()
  vim.lsp.inline_completion.select({ count = 1 })
end, { desc = 'Next Copilot inline completion' })
vim.keymap.set('i', '<M-[>', function()
  vim.lsp.inline_completion.select({ count = -1 })
end, { desc = 'Previous Copilot inline completion' })

-- Toggle inline ghost text globally
vim.keymap.set('n', '<leader>ct', function()
  if vim.lsp.inline_completion.is_enabled() then
    vim.lsp.inline_completion.enable(false)
  else
    vim.lsp.inline_completion.enable(true)
  end
end, { desc = 'Toggle Copilot inline suggestion' })
```

`<C-l>` is deliberately chosen over `<Tab>` because `<Tab>` is the 0.12 default for snippet placeholder navigation and would conflict. Keeps the existing `<leader>ct` toggle.

### 4. `lua/config/blink-cmp.lua` (new)

```lua
require('blink.cmp').setup {
  keymap = { preset = 'default' }, -- C-y accept, C-n/C-p navigate, C-space open
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        async = true,
        score_offset = 100, -- prioritize Copilot items
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
```

### 5. `init.lua`
- `require 'config.copilot'` (still exists, now configures native inline) order stays fine.
- **Add** `require 'config.blink-cmp'` after `require 'pack'` and before `require 'lsp'` so blink.cmp is initialized before `LspAttach` fires.

### 6. `lua/options.lua`
- `completeopt = { 'menuone', 'noselect', 'noinsert' }` (line 68) — keep as-is. blink.cmp reads this.
- No other changes.

### 7. `CLAUDE.md`
- Update the **Native features replacing plugins** table: remove the "Completion" row (blink.cmp now owns it) or change "Was" column accordingly.
- Update the **Startup flow** and the `config/copilot.lua` description to reflect native inline completion rather than `copilot.vim`.
- Update **Gotchas**: note that blink.cmp must initialize before `LspAttach`, and that Copilot-as-popup requires `copilot-language-server` (not copilot.vim).

## Critical files

- `lua/pack.lua` — plugin list (add blink, remove copilot.vim)
- `lua/lsp.lua:176-178` — remove native completion, add native inline_completion
- `lua/config/copilot.lua` — repurpose for inline completion keymaps
- `lua/config/blink-cmp.lua` — new
- `init.lua:29,37` — require order
- `CLAUDE.md` — doc updates

## Reused / existing functionality

- `copilot-language-server` is already registered in `lsp.lua:55-111` — no changes to the LSP config block itself. Both inline_completion and sidekick NES will consume the same client.
- `:LspCopilotSignIn` / `:LspCopilotSignOut` commands (lsp.lua:69-109) still work.
- sidekick.nvim NES keymaps (`]e`, `[e`, `<leader>e*`) remain untouched.
- Mason already installs `copilot-language-server` (no `ensure_installed` change needed).

## Verification

1. **Remove copilot.vim cleanly**: after editing `pack.lua`, run `:lua vim.pack.update()` or restart; confirm `~/.local/share/nvim/pack/core/opt/copilot.vim` is gone (vim.pack auto-removes plugins not in the spec).
2. **blink.cmp binary**: after first load, check `:checkhealth blink.cmp`. If the Rust binary is missing it will warn and fall back to the Lua fuzzy matcher — functional but slower.
3. **Popup items**: open a Lua or Python file. Type `vim.` or a function name prefix. Confirm the popup shows LSP items + (once signed in) Copilot items with a distinct icon.
4. **Inline ghost text**: keep typing to wait for Copilot's multi-line suggestion. Press `<C-l>` to accept. Press `<M-]>` / `<M-[>` to cycle candidates. Press `<leader>ct` to toggle.
5. **NES still works**: trigger a distant edit suggestion (refactor in a function). Confirm `]e`/`<leader>ee` still navigate/apply.
6. **Sign-in flow**: `:LspCopilotSignOut` then `:LspCopilotSignIn`. Verify the device-flow prompt still works.
7. **Snippet placeholders**: expand a lua_ls function snippet (`callSnippet = 'Replace'`) and confirm `<Tab>` still jumps placeholders — no conflict with `<C-l>` inline-accept.
8. **No regressions**: run `:checkhealth`, `:lua vim.pack.update()`, confirm telescope, gitsigns, treesitter unaffected.

## Risks / tradeoffs

- **blink.cmp is a new moving part** — it has a Rust binary, release channel, and opinions about key handling. The payoff is Copilot popup items plus better fuzzy matching; the cost is one more plugin to keep up to date.
- **Keymap collision**: double-check any custom insert-mode maps in `keymaps.lua` for `<C-l>`, `<M-]>`, `<M-[>`. If taken, pick alternatives.
- **First-load delay**: blink.cmp's Rust binary downloads on first `vim.pack.update()`. If pack.lua's build hook story can't handle this automatically, you may need a one-off `cargo build --release` in the plugin dir (documented in blink.cmp install docs).
- **`vim.lsp.inline_completion` is new** in 0.12 — if API shapes change in a point release, the keymap helpers may need small adjustments.
