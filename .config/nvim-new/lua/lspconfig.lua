-- vim.lsp.config("phpactor", {
--   cmd = { "run-phpactor-docker" },
--   cmd_cwd = vim.fn.getcwd(),
--   root_markers = { "composer.json", ".git" },
-- })

vim.lsp.enable({
  'lua_ls',
  'gopls',
  'templ',
  'sqls',
  'html',
  'phpantom_lsp',
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
--       vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })

local function wrap(fn, opts)
  return function()
    fn(opts)
  end
end

vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']e', wrap(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }))
vim.keymap.set('n', '[e', wrap(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }))

vim.pack.add({ 'https://github.com/Saghen/blink.cmp' }, { version = "1.*" })
require('blink.cmp').setup({
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "lua" }
})
