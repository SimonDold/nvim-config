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
    vim.keymap.set('n', 'd', function()
        local node = api.tree.get_node_under_cursor()
        api.fs.remove(node)
    end, opts('Remove Node'))
    vim.keymap.set('n', 'a', function ()
       local node = api.tree.get_node_under_cursor()
       if node and node.type == "directory" then
           api.fs.create(node)
       else
           api.fs.create(node.parent)
       end
    end, opts('Add Node'))
  end
})

vim.keymap.set('n', '<leader>ee', ':NvimTreeFindFileToggle<CR>')
