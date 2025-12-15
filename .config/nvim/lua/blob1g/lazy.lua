local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv       = vim.uv or vim.loop

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
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },

    version = '1.*',

    appearance = {
      nerd_font_variant = 'mono'
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-(>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<C-)>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<C-}>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<C-+>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<C-{>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<C-]>'] = { function(cmp) cmp.accept({ index = 6 }) end },
      },

      completion = {
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx) return ctx.idx > 6 and ' ' or tostring(ctx.idx) end,
                highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
              }
            }
          }
        }
      },

      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  { "honza/vim-snippets" },

  { 'echasnovski/mini.nvim', version = false },

  {
    'stevearc/oil.nvim',
    opts = {
      watch_for_changes = true,

      view_options = {
        show_hidden = true
      },

      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
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
  },

  { 'OmniSharp/omnisharp-vim' },

  { 'nanotee/sqls.nvim' },

  {
    'chrisgrieser/nvim-various-textobjs',
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true
      }
    },
  },

  {
    'junegunn/vim-easy-align',
    init = function()
      vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
    end
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "ej-shafran/compile-mode.nvim",
    version = "latest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- if you want to enable coloring of ANSI escape codes in compilation output, add:
      { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
      vim.keymap.set('n', '<d-x>c', ':wa | Recompile<cr>')
      ---@type CompileModeOpts
      vim.g.compile_mode = {
        -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
        -- set this to fix tab completion in command mode:
        -- input_word_completion = true,

        -- to add ANSI escape code support, add:
        -- baleia_setup = true,

        -- to make `:Compile` replace special characters (e.g. `%`) in
        -- the command (and behave more like `:!`), add:
        -- bang_expansion = true,
      }
    end
  },

  {
    'editorconfig/editorconfig-vim',
  },

  {
    'chrisbra/NrrwRgn',
    config = function ()
      vim.keymap.set('x', '<C-x>n', ':NR!<cr>')
    end
  },
})
