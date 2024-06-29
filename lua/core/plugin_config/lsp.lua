local lsp_zero = require('lsp-zero')

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require("mason").setup()
  require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "clangd"
  }
})


local cmp = require('cmp')
local cmp_select = {
  behavior = cmp.SelectBehavior.Select
}
cmp.setup({
  mapping = cmp.mapping.preset.insert({

    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-l>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  })
})

lsp_zero.set_preferences({
  sign_icons = { }
})

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").lua_ls.setup {
  on_attach = on_attach
}

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  -- find nearest CMakeLists.txt, 
  -- create compile_commands.json based on it
  -- move it compile_commands.json to .
  -- This ensures that clangd can conncet the .h with the .cc files.
  os.execute("pwd"),
  os.execute("cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON $(dirname $(find . -name CMakeLists.txt -print -quit))"),
  os.execute("mv $(dirname $(find . -name CMakeLists.txt -print -quit))/compile_commands.json ."),
}
