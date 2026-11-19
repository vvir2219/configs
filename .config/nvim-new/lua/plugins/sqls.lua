vim.pack.add({ 'https://github.com/nanotee/sqls.nvim' })

-- lsp

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
