# Register Behavior: Your Config vs Default Neovim

## Test Scenario
1. Execute `yt.` to yank text "yanked_text_here" 
2. Execute `ciw` to change word "change_this_word"
3. Check what's in registers ", 0, and +

## Results

### DEFAULT NEOVIM (without clipboard=unnamedplus)

**After `yt.` (yank):**
- Register `"` (unnamed): `yanked_text_here`
- Register `0`: `yanked_text_here` ✅
- Register `+`: (system clipboard - unchanged)

**After `ciw` (change word):**
- Register `"` (unnamed): `change_this_word` (the deleted text)
- Register `0`: `yanked_text_here` ✅ PRESERVED!
- Register `+`: (system clipboard - unchanged)

**Result:** You can paste with `"0p` and get your yanked text!

---

### YOUR CONFIG (with clipboard=unnamedplus)

**After `yt.` (yank):**
- Register `"` (unnamed): `yanked_text_here`
- Register `0`: `yanked_text_here` ✅
- Register `+`: `yanked_text_here` ✅ (synced to system clipboard)

**After `ciw` (change word):**
- Register `"` (unnamed): `change_this_word` (the deleted text)
- Register `0`: `yanked_text_here` ✅ STILL PRESERVED!
- Register `+`: `change_this_word` ⚠️ OVERWRITTEN! (synced to system clipboard)

**Result:** Register 0 DOES have your yanked text, but the system clipboard (+) was overwritten!

---

## The Real Issue

Your system IS behaving correctly for register 0! The problem is:

1. With `clipboard=unnamedplus`, the default register for paste is `+` (system clipboard)
2. When you press `p`, it pastes from `+`, not from `0`
3. The `c` (change) command overwrites register `+` with deleted text
4. So `p` pastes the deleted text instead of your yanked text

## Solutions

### Option A: Paste from register 0 explicitly
```
"0p  (instead of just p)
```

### Option B: Map a convenient key to paste from register 0
```lua
keymap("n", "<leader>p", '"0p', opts)  -- Paste last yank
```

### Option C: Make change commands use black hole register
```lua
keymap("n", "c", '"_c', opts)  -- Change doesn't affect registers
keymap("v", "c", '"_c', opts)
```

### Option D: Remove clipboard=unnamedplus
Then manually use `"+y` and `"+p` for system clipboard

---

## Summary

**Default Neovim:** Register 0 is preserved ✅, but clipboard not synced
**Your Config:** Register 0 is preserved ✅, but `p` uses `+` which gets overwritten

The issue isn't that register 0 is broken—it's that you're pasting from the wrong register!
