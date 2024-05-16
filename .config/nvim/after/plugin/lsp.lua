local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })

  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('v', '<Leader>f', vim.lsp.buf.format, opts)
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_snipmate').lazy_load()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  mapping = {
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

-- diagnostics

vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
})

-- sql db connection

require'lspconfig'.sqls.setup{
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  end,

  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = 'host=localhost port=5432 user=postgres password=password dbname=postgres sslmode=disable',
        },
      },
    },
  },
}

