-- ~/.config/nvim/lua/plugins/lsp-feedback.lua
return {
  'j-hui/fidget.nvim',
  tag = 'legacy',
  config = function()
    require('fidget').setup({
      -- Opções de customização, se desejar
    })
  end,
}