-- plugins.lua

local fn = vim.fn
local cmd = vim.cmd

-- Install packer if not already installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  cmd([[packadd packer.nvim]])
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
-- cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

-- plugin config file
local function get_config(name)
  return string.format('require("plugins.%s")', name)
end

return require('packer').startup(function(use)
  use({ -- Packer can manage itself
    'wbthomason/packer.nvim',
  })

  use({ -- Nord colorscheme (nvim)
    'shaunsingh/nord.nvim',
  })

  use({ -- lsp manager
    'williamboman/mason.nvim',
    config = get_config('mason'),
  })

  -- use({ -- lsp installer/updater
  --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   config = get_config('mason-tool-installer'),
  -- })

  use({ -- Bridges mason.nvim with nvim-lspconfig
    'williamboman/mason-lspconfig.nvim',
    config = get_config('mason-lspconfig'),
    requires = {
      'williamboman/mason.nvim',
    },
    after = {
      'mason.nvim',
    },
  })

  use({ -- Configurations for LSP
    'neovim/nvim-lspconfig',
    config = get_config('lspconfig'),
    requires = {
      'williamboman/mason-lspconfig.nvim',
    },
    after = {
      'mason-lspconfig.nvim',
    },
  })

  use({ -- formatters and linters
    'jose-elias-alvarez/null-ls.nvim',
    config = get_config('null-ls'),
    requires = {
      'nvim-lua/plenary.nvim',
    },
  })

  use({ -- Bridges mason.nvim with null-ls
    'jayp0521/mason-null-ls.nvim',
    config = get_config('mason-null-ls'),
    requires = {
      'jose-elias-alvarez/null-ls.nvim',
      'williamboman/mason.nvim',
    },
    after = {
      'null-ls.nvim',
      'mason.nvim',
    },
  })

  -- use({ -- DAPs
  --   'mfussenegger/nvim-dap',
  --   config = get_config('dap'),
  -- })

  use({ -- Show function signature
    'ray-x/lsp_signature.nvim',
    config = get_config('lsp_signature'),
  })

  use({ -- code snippets
    'L3MON4D3/LuaSnip',
    config = get_config('luasnip'),
    requires = {
      'rafamadriz/friendly-snippets',
    },
  })

  use({ -- completions
    'hrsh7th/nvim-cmp',
    config = get_config('cmp'),
    -- after = "lspkind-nvim",
    requires = {
      'hrsh7th/cmp-nvim-lsp', -- show data sent by the language server
      'hrsh7th/cmp-buffer', -- provides suggestions based on the current file
      'hrsh7th/cmp-path', -- gives completions based on the filesystem
      'hrsh7th/cmp-cmdline',
      { -- code snippets
        'saadparwaiz1/cmp_luasnip',
        requires = {
          'L3MON4D3/LuaSnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
  })

  use({ -- highlighting
    'nvim-treesitter/nvim-treesitter',
    config = get_config('treesitter'),
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor', -- Refactor module
      'nvim-treesitter/nvim-treesitter-textobjects', -- Syntax aware text-objects, select, move, swap, and peek support.
      'nvim-treesitter/nvim-treesitter-context', -- Show code context
    },
  })

  use({ -- Markdown Preview
    'iamcco/markdown-preview.nvim',
    run = function()
      fn['mkdp#util#install']()
    end,
  })

  use({ -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    config = get_config('telescope'),
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter', -- optional,
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
      'nvim-telescope/telescope-symbols.nvim', -- emojis, glyphs, etc.
      'nvim-telescope/telescope-file-browser.nvim',
      { -- lightspeed!
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
      { -- media finder
        'nvim-telescope/telescope-media-files.nvim',
        requires = {
          'nvim-lua/popup.nvim',
        }, -- requires: uberzug, fmpegthumbnailer
      },
      'LinArcX/telescope-env.nvim', -- environment variables
      { -- code snippets (luasnips)
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip',
        requires = {
          'L3MON4D3/LuaSnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
    -- opt packages: ripgrep, fd
  })

  -- use({ -- file explorer
  --   'kyazdani42/nvim-tree.lua',
  --   tag = 'nightly', -- optional, updated every week. (see issue #1193)
  --   config = get_config('nvim-tree'),
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- for file icons
  --   },
  -- })

  use({ -- git extras
    'lewis6991/gitsigns.nvim',
    config = get_config('gitsigns'),
  })

  use({ -- autopair brackets/quotes
    'windwp/nvim-autopairs',
    config = get_config('nvim-autopairs'),
  })

  use({ -- show indent lines
    'lukas-reineke/indent-blankline.nvim',
    config = get_config('indent_blankline'),
  })

  use({ -- color highlighter
    'NvChad/nvim-colorizer.lua',
    config = get_config('colorizer'),
  })

  use({ -- manage multiple terminal windows
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
    config = get_config('toggleterm'),
  })

  use({ -- commenter
    'numToStr/Comment.nvim',
    config = get_config('Comment'),
  })

  use({ -- show diagnostics & references
    'folke/trouble.nvim',
    config = get_config('trouble'),
    requires = {
      'kyazdani42/nvim-web-devicons', -- for icons
    },
  })

  use({ -- mkdir
    'jghauser/mkdir.nvim',
  })

  use({ -- displays popup with possible keybinds
    'folke/which-key.nvim',
    config = get_config('which-key'),
  })

  use({ -- displays popup with possible keybinds
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').synget_config()
  end
end)
