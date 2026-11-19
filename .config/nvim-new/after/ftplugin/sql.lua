local opts = { silent = true, buffer = true }
vim.opt_local.splitbelow = false
vim.keymap.set({ "n", "x" }, "<leader>r", "<Plug>(sqls-execute-query)", opts)
vim.keymap.set({ "n", "x" }, "<leader>rv", "<Plug>(sqls-execute-query-vertical)", opts)
