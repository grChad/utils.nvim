<h1 align="center">utils.nvim</h1>

> Plugin de utilidades como cmp.opts.formatting, `StatusColumn` y más.


## Instalar

Con [Lazy](https://github.com/folke/lazy.nvim):

```lua
{ 'grChad/utils.nvim', lazy = false },
```

Con [Packer](https://github.com/wbthomason/packer.nvim):

```lua
use { 'grChad/utils.nvim' }
```

## Uso:
#### setup StatusColumn

Opciones por defecto. Puedes modificar parcial o totalmente todas las opciones.

```lua
local grUtils = require('gr-utils')
grUtils.statuscolumn.setup({
   disabled = {
      'alpha', 'dashboard', 'NvimTree',  'Outline', 'help', 'lspinfo', 'packer', 'qf',
      'startify', 'startuptime', 'vimfiler', 'vimhelp', 'viminfo', 'undotree', 'lazy',
      'mason', 'TelescopePrompt', 'Telescope', 'toggleterm', 'diff', 'fugitiveblame'
   },
   add_with_fold = {}, -- add more filetypes with 'fold'
   without_fold = {}, -- add filetypes without 'fold'
})
```

En `disabled` puedes agregar otros que no están en la lista, se combinaran en una nueva lista.

#### Formatting Cmp

Configurar dentro de `hrsh7th/nvim-cmp`

```lua
local cmp = require('cmp')
cmp.setup({
    --- other code
    formatting = { format = require('gr-utils').cmp_format },
})
```

#### Toggle Bolean

Una función que alterna valores como:
```lua
{ 'true', 'false' }
{ 'yes', 'no' }
{ 'on', 'off' }
```

Se puede usar junto con un atajo de teclado:
```lua
vim.keymap.set ('n', '<leader>b', "<cmd>lua require('gr-utils').toggle_bool()<CR>", { desc = 'Toggle boolean' })
```

#### Search

Para buscar coincidencias y enumerarlo, También se puede usar como atajo de teclado:

```lua
vim.keymap.set('n', '<leader>m', "<cmd>lua require('gr-utils').search.clear()<CR>", { silent = true, desc = 'no highlight' })
vim.keymap.set('n', 'n', 'nzz' .. "<cmd>lua require('gr-utils').search.run()<CR>", { desc = 'Next search' })
vim.keymap.set('n', 'N', 'Nzz' .. "<cmd>lua require('gr-utils').search.run()<CR>", { desc = 'Previous search' })
```

#### rename

Para renombrar variables Lsp, uso con atajo de teclado.

```lua
vim.keymap.set('<leader>re', "<cmd>lua require('gr-utils').rename.run()<CR>", {desc = 'rename variable'})
```
