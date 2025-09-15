# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Lua Formatting
- `stylua .` - Format all Lua files using the configuration in stylua.toml (2 spaces, 120 columns)

### Nix Development Environment
- `nix develop` - Enter development shell with lua-language-server and stylua
- Dependencies managed via flake.nix

### Neovim Testing
- Test configuration by launching: `nvim -u init.lua`
- Check health: `:checkhealth` within Neovim

## Architecture Overview

This is a heavily customized Neovim configuration built on top of LazyVim framework with significant modifications.

### Core Structure
- **Entry Point**: `init.lua` - Sets up lazy.nvim plugin manager and core settings
- **Configuration**: `lua/config/` - Core Neovim settings (options, keymaps, autocmds)
- **Plugin Management**: `lua/plugins/` - Plugin configurations organized by functionality
- **LazyVim Utils**: `lua/lazyvim/util/` - Custom utility functions for LazyVim framework

### Key Configuration Details

#### Root Detection
- Uses custom root spec: `{ "lsp", { ".git", ".jj", "lua" }, "cwd" }`
- Jujutsu VCS support alongside Git
- Ignores 'copilot' LSP for root detection

#### Plugin Architecture
- **Lazy Loading**: Most plugins load on-demand via lazy.nvim
- **Import Structure**: Plugins imported from multiple module paths
- **Disabled**: neo-tree (file explorer disabled)
- **Performance**: Optimized with disabled runtime plugins

### Plugin Categories
- **LSP**: `plugins/lsp/` - Language server configurations and keymaps
- **Completion**: blink.cmp for autocompletion
- **UI**: Custom statusline, bufferline, theming (cyberdream/modus)
- **Search**: fzf-lua for fuzzy finding
- **Formatting**: conform.nvim with language-specific formatters
- **Movement**: flash.nvim, mini.move for enhanced navigation

### Custom Features
- **chezmoi Integration**: `<leader>sz` applies chezmoi configuration
- **Diagnostic Management**: Custom functions to yank diagnostics to clipboard
- **Theme Switching**: Quick keybinds for cyberdream/modus themes
- **External Terminal**: Integration with footclient for file manager
- **Neovide Support**: Special keybindings and settings for Neovide GUI

### Key Custom Keymaps
- `<Space>` as leader key, `\` as local leader
- `<C-]>` / `<A-[>` for buffer navigation
- `<Alt-s/v>` for window splitting
- `<Tab>` cycles through code buffers (skips special buffers)
- `mm` remapped to `%` for bracket matching

## Development Guidelines

When modifying this configuration:
1. Follow the existing plugin structure in `lua/plugins/`
2. Use LazyVim utilities where available (`LazyVim.format`, `LazyVim.root`, etc.)
3. Maintain lazy loading patterns for performance
4. Test with both terminal Neovim and Neovide if applicable
5. Consider both light (modus) and dark (cyberdream) theme compatibility