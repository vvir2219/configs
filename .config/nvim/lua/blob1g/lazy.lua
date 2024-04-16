local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.6",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    }
  },

  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.cmd 'au BufRead,BufNewFile *.templ set filetype=templ'
    end
  },
  { "nvim-treesitter/playground" },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } }
  },

  { "mbbill/undotree" },

  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-endwise" },
  { "tpope/vim-rails" },
  { "tpope/vim-sleuth" },

  { 'folke/tokyonight.nvim' },
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },

  { "folke/neodev.nvim",                opts = {} },

  { "honza/vim-snippets" },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  { 'saadparwaiz1/cmp_luasnip' },

  {
    'terryma/vim-expand-region',
    init = function()
      vim.keymap.set('x', '_', '<Plug>(expand_region_shrink)')
    end
  },

  { 'echasnovski/mini.nvim',   version = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- @type Flash.Config
    opts = {
      modes = {
        char = { enabled = false },
      }
    },
    -- stylua: ignore
    keys = {
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
  { 'stevearc/oil.nvim' }
})
