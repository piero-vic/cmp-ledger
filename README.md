# cmp-ledger

nvim-cmp source for ledger accounts.

## Setup

You need to have [ledger](https://github.com/ledger/ledger) installed.

Add the package to your package manager.

```lua
use 'piero-vic/cmp-ledger'
```

Setup the completion source.

```lua
require('cmp').setup({
  sources = {
    { name = 'ledger' },
  },
})
```

## License

[MIT](./LICENSE)
