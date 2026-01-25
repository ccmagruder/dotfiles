# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Apply the home-manager configuration
home-manager switch --flake .

# Update flake inputs (dependencies)
nix flake update

# Update a specific input
nix flake lock --update-input nixpkgs
```

## Architecture Overview

This is a **Nix Flakes-based Home Manager configuration** for managing a personal development environment. The flake outputs a `homeConfigurations.remote` that combines user settings, IDE tooling, and encrypted secrets.

### Module Structure

```
flake.nix              # Entry point - defines inputs and composes modules
├── home.nix           # User identity, packages, state version
├── ide/               # Development environment module
│   ├── default.nix    # Aggregates: git, tmux, zsh, nixvim
│   ├── git.nix        # Git config + sops-nix secret for GitHub token
│   ├── tmux.nix       # Tmux with vim-tmux-navigator integration
│   ├── zsh.nix        # Zsh + oh-my-zsh + custom aliases
│   └── nixvim/        # Neovim IDE configuration
│       ├── default.nix    # Core settings, keybindings, base plugins
│       ├── lsp.nix        # nil_ls and nixd language servers
│       ├── telescope.nix  # Fuzzy finder (ripgrep, fd)
│       ├── nvim-tree.nix  # File tree sidebar
│       ├── lualine.nix    # Status/tabline
│       ├── bufdelete.nix  # Buffer management
│       └── gitsigns.nix   # Git blame/signs
└── secrets/
    └── secrets.yaml   # SOPS-encrypted secrets (AGE encryption)
```

### Key Patterns

- **Module composition**: `default.nix` files aggregate related submodules via `imports = [...]`
- **Flake inputs passed to modules**: Modules receive `{ config, pkgs, inputs, ... }` for access to dependencies
- **Secrets**: sops-nix decrypts `secrets.yaml` using the SSH host key at `/etc/ssh/ssh_host_ed25519_key`
- **Cross-tool integration**: Tmux and Neovim share navigation via `vim-tmux-navigator`

### Neovim Keybindings (Leader = Space)

| Key | Action |
|-----|--------|
| `<leader>s` | Save |
| `<leader>q` | Quit all |
| `<leader><Tab>` | Next buffer |
| `<leader>w` | Delete buffer |
| `<leader>e` | Toggle file tree |
| `<leader>fg` | Live grep |
| `gd` | Go to definition |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>j/k` | Next/prev diagnostic |

### Shell Aliases (from zsh.nix)

- `ide` - Launches tmux session with nvim in multiple windows
- `gs` - git status
- `update` - sudo nixos-rebuild test
