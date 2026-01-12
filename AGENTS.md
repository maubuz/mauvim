# Agent Guidelines for Neovim Configuration

## Overview
Personal Neovim configuration forked from kickstart-modular.nvim. Written in Lua, using lazy.nvim plugin manager.

## Build/Lint/Test Commands
- **Format Lua**: `stylua .` (check: `stylua --check .`)
- **Format specific file**: `stylua path/to/file.lua`
- **Check health**: `:checkhealth` (run inside nvim)
- **No automated tests**: This is a configuration repo, not a project with tests

## Code Style
- **Formatting**: Use StyLua with settings from `.stylua.toml`
  - Column width: 160, indent: 2 spaces, quote style: auto-prefer-single, call parentheses: none
- **File modeline**: End Lua files with `-- vim: ts=2 sts=2 sw=2 et`
- **Imports**: Use `require 'module'` (no parentheses for single string argument)
- **Comments**: Use `--` for single-line, `--[[  ]]` for multi-line
- **Naming**: snake_case for variables/functions, descriptive names
- **Plugin structure**: Return table from plugin files in `lua/*/plugins/`
- **Configuration**: Use `opts = {}` for simple setup, `config = function()` for complex setup
- **Error handling**: Not emphasized in this config; follow existing patterns

## Key Conventions
- Leader key: Space
- Plugin manager: lazy.nvim
- LSP via mason.nvim + nvim-lspconfig
- Formatters via conform.nvim, linters via nvim-lint
