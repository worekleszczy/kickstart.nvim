return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      require('lsp-zero.cmp').extend()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero.cmp').action()

      cmp.setup({
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      local lsp = require('lsp-zero')

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })

        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
        -- vim.keymap.set('n', '<F4>', '<cmd>CodeActionMenu<cr>', { buffer = true })
      end)


      lsp.setup_servers({ 'metals' })

      -- format on save
      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['gopls'] = { 'go' },
          ['metals'] = { 'scala', "sc" },
          -- if you have a working setup with null-ls
          -- you can specify filetypes it can format.
          -- ['null-ls'] = {'javascript', 'typescript'},
        }
      })

      -- (Optional) Configure lua language server for neovim
      --
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
      lspconfig.gopls.setup { settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
      }

      lsp.setup()
    end
  }
}
