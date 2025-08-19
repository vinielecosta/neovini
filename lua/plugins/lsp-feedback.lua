-- ~/.config/nvim/lua/plugins/lsp-feedback.lua
-- Este ficheiro configura o fidget.nvim, um plugin que adiciona um feedback
-- visual discreto no canto do ecrã, informando sobre o progresso
-- das tarefas do LSP (ex: "Formatting...", "Analyzing...").

return {
  'j-hui/fidget.nvim',
  -- A tag 'legacy' é recomendada pelo autor do plugin para garantir
  -- compatibilidade com a versão mais estável.
  tag = 'legacy',
  config = function()
    require('fidget').setup({
      -- As opções de customização podem ser adicionadas aqui.
      -- A configuração padrão já é excelente, por isso não é necessário
      -- adicionar nada para que o plugin funcione.
    })
  end,
}
