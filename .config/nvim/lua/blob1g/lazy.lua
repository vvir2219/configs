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
      vim.cmd 'au BufRead,BufNewFile go.mod set filetype=gomod'
      vim.cmd 'au BufRead,BufNewFile .envrc set filetype=bash'
      vim.cmd 'au BufRead,BufNewFile .env.* set filetype=bash'
    end
  },
  { "nvim-treesitter/playground" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

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
  { 'hrsh7th/cmp-buffer' },
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

  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true
      }
    }
  },

  { 'jremmen/vim-ripgrep' },

  {
    'ggandor/leap.nvim',
    config = function()
      -- vim.keymap.set('n', 's', '<Plug>(leap)')
      -- vim.keymap.set('n', '<C-s>', '<Plug>(leap-from-window)')
      vim.keymap.set('n', 's', function()
        require('leap').leap {
          target_windows = require('leap.user').get_focusable_windows()
        }
      end)
      vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)')
    end
  },

  { 'joerdav/templ.vim' },

  {
    'romgrk/replace.vim',
    config = function()
      vim.keymap.set({ 'n', 'x' }, 'R', '<Plug>ReplaceOperator')
    end
  },

  {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end
  },

  { 'jeetsukumaran/vim-indentwise' },

  {
    'chaoren/vim-wordmotion',
    init = function()
      vim.g.wordmotion_prefix = ','
    end
  },

  { 'haya14busa/is.vim' },
  {
    'haya14busa/vim-asterisk',
    init = function()
      vim.g['asterisk#keeppos'] = 1
      vim.api.nvim_set_keymap('n', '*', '<Plug>(asterisk-z*)', {})
    end
  },

  { 'subnut/visualstar.vim' },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_mappings_enabled = 0
      vim.g.vimtex_view_automatic = 0
    end,
  }
})
