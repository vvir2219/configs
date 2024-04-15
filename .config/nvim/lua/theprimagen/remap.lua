vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- useful thingies

vim.keymap.set('n', '<C-c>', '<C-^>')

-- dvorak remappings

vim.keymap.set({ 'n', 'x' }, 'h', 'j')
vim.keymap.set({ 'n', 'x' }, 't', 'k')
vim.keymap.set({ 'n', 'x' }, 'n', 'l')

vim.keymap.set({ 'n', 'x' }, ';', ':')
vim.keymap.set({ 'n', 'x' }, ':', ';')

vim.keymap.set({ 'n', 'x' }, 'm', 'n')
vim.keymap.set({ 'n', 'x' }, 'M', 'N')

-- some benefits

vim.keymap.set({ 'n', 'x' }, '-', '$')
vim.keymap.set({ 'n', 'x' }, '_', '^')
vim.keymap.set({ 'n', 'x' }, 'N', '<C-w><C-w>')
vim.keymap.set({ 'n', 'x' }, 'H', '8<Down>')
vim.keymap.set({ 'n', 'x' }, 'T', '8<Up>')
