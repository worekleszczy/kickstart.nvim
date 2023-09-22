return {
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.cmd [[silent! GitBlameDisable]]
    end
  },
  {
    "sindrets/diffview.nvim",
    setup = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    setup = true
  }
}
