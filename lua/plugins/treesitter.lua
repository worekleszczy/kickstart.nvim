return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ":TSUpdate",
  config = function()
    -- [[ Configure Treesitter ]]
    -- See `:help nvim-treesitter`
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { 'go', 'lua', 'python', 'vimdoc', 'vim', 'terraform', 'smithy', 'scala' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['aF'] = '@function.outer',
            ['iF'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ["ak"] = "@key",
            ["av"] = "@value",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
            [']a'] = '@parameter.outer',
            [']v'] = '@value',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
            [']A'] = '@parameter.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[a'] = '@parameter.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[A'] = '@parameter.outer',
            ['[v'] = '@value',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "json",
      callback = function()
        vim.opt_local.foldmethod = "expr"                     -- Use expression-based folding
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()" -- Tree-sitter fold expression

        local ts_utils = require 'nvim-treesitter.ts_utils'

        -- Function to move to the next sibling key
        local function go_to_sibling_key(direction)
          local current_node = ts_utils.get_node_at_cursor()

          -- Find the nearest `pair` node (JSON key-value pair)
          while current_node and current_node:type() ~= "pair" do
            current_node = current_node:parent()
          end

          if not current_node then
            print("No key found under cursor!")
            return
          end

          -- Move to the sibling node
          local sibling
          if direction == "next" then
            sibling = current_node:next_named_sibling()
          else
            sibling = current_node:prev_named_sibling()
          end

          if sibling and sibling:type() == "pair" then
            -- Move the cursor to the sibling's `key` node
            local key_node = sibling:field("key")[1]
            if key_node then
              ts_utils.goto_node(key_node)
            else
              print("Sibling key not found!")
            end
          else
            print("No more siblings!")
          end
        end

        -- Keymaps for navigating sibling keys
        vim.keymap.set("n", "]k", function() go_to_sibling_key('next') end, { noremap = true, silent = true })
        vim.api.set("n", "[k", function() go_to_sibling_key('prev') end, { noremap = true, silent = true })
      end,
    })
  end
}
