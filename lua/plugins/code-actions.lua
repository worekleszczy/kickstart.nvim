return {
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    'kosayoda/nvim-lightbulb',
    opts = { autocmd = { enabled = true } },
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function (_, opt)
      require("core.remap").load_mapping
      
    end

  }
}
