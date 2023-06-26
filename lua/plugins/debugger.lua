return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { "<leader>db",
        "<cmd> DapToggleBreakpoint <CR>",
        "Add breakpoint at line"
      },
      { "<leader>dus",
        function()
          local widgets = require('dap.ui.widgets');
          local sidebar = widgets.sidebar(widgets.scopes);
          sidebar.open();
        end,
        "Open debugging sidebar"
      }
    },
  },
  {
    'leoluz/nvim-dap-go',
    config = true,
    keys = {
      { "<leader>dgt",
        function()
          require('dap-go').debug_test()
        end,
        "Debug go test"
      },
      { "<leader>dgl",
        function()
          require('dap-go').debug_last()
        end,
        "Debug last go test"
      }
    }
  }
}
