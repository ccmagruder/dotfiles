# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Apply configuration for a specific host
home-manager switch --flake .#alien    # x86_64-linux
home-manager switch --flake .#vector   # x86_64-linux
home-manager switch --flake .#studio   # aarch64-darwin
home-manager switch --flake .#mbp      # aarch64-darwin

# Update flake inputs (dependencies)
nix flake update

# Update a specific input
nix flake lock --update-input nixpkgs
```

## Architecture Overview

This is a **Nix Flakes-based Home Manager configuration** for managing a personal development environment across four machines (two Linux, two macOS). All machines share a common `ide/` module with per-host home files for identity and host-specific packages.

### Flake Inputs

- `nixpkgs` — nixos-unstable
- `home-manager` — follows nixpkgs
- `nixvim` — Neovim configured via Nix, follows nixpkgs
- `flake-parts` — flake composition
- `claude-code-nix` — Claude Code CLI package
- `bat-nvim` — custom bat.nvim plugin

### Module Structure

```
flake.nix                  # Entry point - 4 homeConfigurations (alien, vector, studio, mbp)
├── home-alien.nix         # x86_64-linux identity + packages
├── home-vector.nix        # x86_64-linux identity + packages
├── home-studio.nix        # aarch64-darwin identity + packages
├── home-mbp.nix           # aarch64-darwin identity + packages
└── ide/                   # Shared IDE module (all hosts)
    ├── default.nix        # Aggregates: git, tmux, zsh, nixvim
    ├── git.nix            # Git config
    ├── tmux.nix           # Tmux with vim-tmux-navigator integration
    ├── zsh.nix            # Zsh + oh-my-zsh + starship prompt
    └── nixvim/            # Neovim IDE configuration via nixvim
        ├── default.nix    # Core settings, nord theme, keybindings, base plugins
        ├── bat.nix        # bat syntax-highlighted pager integration
        ├── blink-cmp.nix  # Completion engine
        ├── bufdelete.nix  # Buffer management
        ├── gitsigns.nix   # Git blame/signs
        ├── lsp.nix        # LSP servers: nixd, basedpyright, jsonls, clangd
        ├── lualine.nix    # Status/tabline
        ├── navic.nix      # Code context breadcrumbs
        ├── nvim-tree.nix  # File tree sidebar
        ├── telescope.nix  # Fuzzy finder (ripgrep, fd)
        ├── tmux-navigator.nix  # Tmux pane navigation from Neovim
        └── toggleterm.nix # Floating terminal
```

### Key Patterns

- **Module composition**: `default.nix` files aggregate related submodules via `imports = [...]`
- **Flake inputs passed to modules**: Modules receive `{ config, pkgs, inputs, ... }` for access to dependencies
- **Cross-tool integration**: Tmux and Neovim share navigation via `vim-tmux-navigator`

### Neovim Keybindings (Leader = Space)

| Key | Action |
|-----|--------|
| `<leader>s` | Save |
| `<leader>q` | Quit all |
| `<leader><Tab>` | Next buffer |
| `<leader>w` | Delete buffer (keep window) |
| `<leader>e` | Toggle file tree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>j/k` | Next/prev diagnostic |
| `gd` | Go to definition |
| `gt` | Go to type definition |
| `gr` | LSP references (Telescope) |
| `<C-Space>` | Toggle floating terminal |

### Shell Aliases (from zsh.nix)

- `ll` — ls -lah
- `gs` — git status
- `ide` — smug start (launches tmux session)
- `update` — sudo nixos-rebuild test
