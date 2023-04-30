return {
  'nvim-tree/nvim-tree.lua',
  -- version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = true,
  keys = {
      {'<leader>1', function()
        require('nvim-tree.api').tree.find_file{open = true, update_root = '<bang>'}
      end
    },
  }
}
