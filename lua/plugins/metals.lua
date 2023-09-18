return {
  'scalameta/nvim-metals',
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sm", function()
      require("telescope").extensions.metals.commands()
    end, "search metals" }
  }
}
