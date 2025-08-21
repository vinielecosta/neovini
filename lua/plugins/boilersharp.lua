-- ~/.config/nvim/lua/plugins/boilersharp.lua
-- Este ficheiro configura o boilersharp.nvim, um plugin especializado
-- em gerar templates (boilerplate) para ficheiros C#, como classes,
-- interfaces, enums, etc., seguindo as convenções do .NET.

return {
  "DestopLine/boilersharp.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- A configuração padrão já é excelente e deteta automaticamente
  -- o namespace com base na sua solução e estrutura de pastas.
  config = function()
    require("boilersharp").setup()
  end,
}
