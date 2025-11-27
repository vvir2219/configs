vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

require('luasnip.loaders.from_snipmate').lazy_load()

-- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
-- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

-- diagnostics

vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
})
vim.keymap.set('n', ']w', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Go to next error" })
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Go to previous error" })

-- sql db connection

vim.lsp.config('sqls', {
  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = os.getenv("DB_EXTERNAL_CONNECTION_STRING"), -- 'host=localhost port=5432 user=postgres password=password dbname=postgres sslmode=disable',
        },
      },
    },
  },
})

-- harperls

vim.lsp.config('harper_ls', {
  settings = {
    userDictPath = "",
    fileDictPath = "",
    linters = {
      SentenceCapitalization = false,
      LongSentences = false,
      Spaces = false,
    },
    codeActions = {
      ForceStable = false
    },
    markdown = {
      IgnoreLinkTitle = false
    },
    diagnosticSeverity = "hint",
    isolateEnglish = false,
    dialect = "American",
    maxFileLength = 120000
  }
})
