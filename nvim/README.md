# Neovim Configuration

A personal Neovim setup written in Lua, with lazy-loaded plugins managed by [lz.n](https://github.com/lumen-oss/lz.n).

## Features

- Lua language server, Treesitter, and formatting on save with StyLua
- File explorer, file finder, completion, and status line
- Four-space indentation, line numbers, and system clipboard integration

## Keymaps

The leader key is `Space`.

- `<Space>e` toggles the file explorer
- `<Space><Space>` opens Telescope file search

## Setup

Place this directory at `~/.config/nvim` and start Neovim. Git is required; the plugin manager is bootstrapped automatically on first launch. The configured Lua language server and StyLua formatter should be available on your `PATH` for language support and formatting.

## About
- version v1.0
- >feat Vladimir Volkov (ff34d)
