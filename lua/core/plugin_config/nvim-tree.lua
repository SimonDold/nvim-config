vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    -- Keymaps only for the nvim-tree buffer
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Parent Node'))
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open Node'))
  end
})

vim.keymap.set('n', '<leader>ee', ':NvimTreeFindFileToggle<CR>')
