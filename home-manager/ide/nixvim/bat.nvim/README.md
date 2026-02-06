# bat.nvim

**B**uild **a**nd **T**est - Run shell commands in a dedicated terminal window. Commands are defined in a JSON config file.

## Installation

### NixVim

```nix
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "bat.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "ccmagruder";
          repo = "bat.nvim";
          rev = "main";
          hash = ""; # nix will tell you the correct hash
        };
      })
    ];

    extraConfigLua = ''
      require("bat").setup({ enabled = true })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>Bat build<cr>";
        options.desc = "Run build";
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>Bat test<cr>";
        options.desc = "Run test";
      }
    ];
  };
}
```

### lazy.nvim

```lua
{
  "ccmagruder/bat.nvim",
  opts = {
    enabled = true,
    path = "$PWD/.bat.json",
  },
}
```

### packer.nvim

```lua
use {
  "ccmagruder/bat.nvim",
  config = function()
    require("bat").setup({
      enabled = true,
      path = "$PWD/.bat.json",
    })
  end,
}
```

## Configuration

Create a `.bat.json` file in your project root:

```json
{
  "build": "make build",
  "test": "npm test",
  "dev": "npm run dev"
}
```

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | boolean | `true` | Enable the plugin |
| `path` | string | `"$PWD/.bat.json"` | Path to JSON config file |

## Usage

```vim
:Bat build   " Runs the 'build' command from .bat.json
:Bat test    " Runs the 'test' command
```

The command opens a vertical split terminal window. Running another command reuses the same window and replaces the previous terminal buffer.

## API

```lua
local bat = require("bat")

-- Run a shell command directly
bat.run("echo hello")

-- Load commands from config file
local cmds = bat.read_json_config(".bat.json")

-- Get or create the bat window
local win_id = bat.open_window()
```

## License

MIT
