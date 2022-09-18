-- plugins/telescope/init.lua
require('plugins.telescope.keymap')

local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      '~/Pictures',
      '~/Videos',
      '.git/',
      '__pycache__',
    },
    mappings = {
      i = {
        ['<Esc>'] = actions.close,
        ['<C-/>'] = 'which_key',
        ['<C-p>'] = actions_layout.toggle_preview,
      },
      n = {
        ['<Esc>'] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      --hidden = true,
      find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
    },
    live_grep = {
      hidden = true,
    },
  },
  extensions = {
    media_files = {
      -- filetypes allowlist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { 'jpg', 'jpeg', 'png', 'webp', 'mp4' },
      find_cmd = 'rg', -- find command (defaults to `fd`)
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('media_files')
require('telescope').load_extension('env')
require('telescope').load_extension('luasnip')
