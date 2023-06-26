return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = true,
  keys = {
    {'<leader>1', function()
        require('nvim-tree.api').tree.find_file{open = true, update_root = false, focus = true}
      end
    },{'<leader>t', function()
        require('nvim-tree.api').tree.toggle{path = '<arg>'}
      end
    }
  }
}
