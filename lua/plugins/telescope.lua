return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      }
    },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          }
        }
      })
      telescope.load_extension("live_grep_args")
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    config = function()
      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
    end,
    keys = {
      {
        '<leader>?',
        function() require('telescope.builtin').oldfiles() end,
        desc =
        '[?] find recently opened files'
      },
      {
        '<leader><space>',
        function() require('telescope.builtin').buffers() end,
        desc =
        '[ ] find existing buffers'
      },
      {
        '<leader>/',
        function()
          -- you can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = '[/] fuzzily search in current buffer'
      },
      {
        '<leader><space>',
        function() require('telescope.builtin').buffers() end,
        desc =
        '[ ] find existing buffers'
      },
      {
        '<leader>sf',
        function() require('telescope.builtin').find_files() end,
        desc =
        '[s]earch [f]iles'
      },
      {
        '<leader>sh',
        function() require('telescope.builtin').help_tags() end,
        desc =
        '[s]earch [h]elp'
      },
      {
        '<leader>sw',
        function() require('telescope.builtin').grep_string() end,
        desc =
        '[s]earch current [w]ord'
      },
      {
        '<leader>sg',
        function() require('telescope').extensions.live_grep_args.live_grep_args() end,
        desc =
        '[s]earch by [g]rep'
      },
      {
        '<leader>sd',
        function() require('telescope.builtin').diagnostics() end,
        desc =
        '[s]earch [d]iagnostics'
      },
      {
        '<leader>sr',
        function() require('telescope.builtin').resume() end,
        desc =
        '[s]earch [r]esume'
      },
      {
        '<leader>sc',
        function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
        desc =
        '[s]earch [c]lasses & symbols'
      },
    },
  }
}
