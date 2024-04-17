local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})

vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>rg', builtin.grep_string, {})
vim.keymap.set('n', '<C-p>', function()
    if not pcall(builtin.git_files) then
        builtin.find_files()
    end
end)
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<leader>tk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>tf', function()
    builtin.lsp_document_symbols({ symbols = 'function' })
end)
