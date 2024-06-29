--require('gitsigns').setup({
--vim.cmd "set statusline+=%{get(b:,'gitsigns_status','')}"
----vim.keymap.set("n", "<leader>gc", vim.gitsigns.preview_hunk)
require('gitsigns').setup {
  on_attach = function(bufnr)
    -- Use vim.keymap.set for gitsigns keymaps
    vim.keymap.set('n', '<leader>hp', function() vim.cmd.Gitsigns('preview_hunk') end, { buffer = bufnr, desc = 'Preview hunk' })
  end
}
vim.cmd "set statusline+=%{get(b:,'gitsigns_status','')}"

