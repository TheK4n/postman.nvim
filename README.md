<div align="center">

# postman.nvim

[Install](#install) • [Usage](#usage)

</div>

---

Neovim plugin for executes shell commands from buffer


## Install

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "thek4n/postman.nvim",
    config = function()
        vim.keymap.set("n", "<Leader>rl", '<cmd>PostmanExec<CR>')
    end
}
```

## Usage

Command: \
`:PostmanExec` \
will execute shell commands from paragraph under cursor


```txt
curl
--get
https://127.0.0.1/api/2.0/user/123


curl
--data "hello"
https://127.0.0.1/api/2.0/user/123

echo
$HOME
```