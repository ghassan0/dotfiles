-- plugins.lua

local fn = vim.fn
local cmd = vim.cmd

-- Install packer if not already installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd [[packadd packer.nvim]]
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer can manage itself

--  use 'neovim/nvim-lspconfig'   -- Configurations for Nvim LSP
  use {   -- Configurations for Nvim LSP
    'neovim/nvim-lspconfig',
    config = function()
      require'lspconfig'.bashls.setup{}   -- bash
      -- sudo npm i -g bash-language-server
    end
  }

  use 'arcticicestudio/nord-vim'  -- Nord colorscheme

  use 'nvim-lua/plenary.nvim'   -- Required by many plugins

  use 'kyazdani42/nvim-web-devicons'    -- icon support
  -- requires: a patched font

  use {   -- highlighting
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use {   -- Markdown Preview
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end
  }

  use {   -- fuzzy finder
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',  -- optional, 
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('telescope').setup{
        defaults = {
          file_ignore_patterns = {
            '.git/',
          },
        },
        pickers = {
          find_files = {
            --hidden = true,
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
          live_grep = {
            hidden = true
          },
          --file_browser = {
          --  hidden = true
          --}
      },
    }
    end
  }
-- opt packages: ripgrep, fd

  use {   -- file explorer
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require("nvim-tree").setup()
    end
  }

  use {   -- git extras
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {   -- autopair
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {   -- show indent lines
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('indent_blankline').setup()
    end
  }

  use {   -- displays popup with possible keybinds
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
