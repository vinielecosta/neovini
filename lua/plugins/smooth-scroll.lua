-- ~/.config/nvim/lua/plugins/smooth-scroll.lua
-- Este ficheiro configura o neoscroll.nvim, um plugin que adiciona
-- animações de rolagem suaves ao Neovim, tornando a navegação
-- no editor mais fluida e visualmente agradável.

return {
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup({
      ---
      -- Título: Mapeamentos Animados
      ---
      -- Tabela que define quais atalhos de teclado de navegação
      -- devem ter o efeito de rolagem suave.
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
      duratio_multiplier = 3.0, -- Multiplicador de duração para animações.

      ---
      -- Título: Configurações Visuais e de Comportamento
      ---
      hide_cursor = true,          -- Esconde o cursor durante a animação de rolagem.
      stop_eof = true,             -- Impede que a rolagem ultrapasse o início ou o fim do ficheiro.
      respect_scrolloff = false,   -- Permite que a rolagem vá até ao fim do ficheiro.
      cursor_scrolls_alone = true, -- Permite que apenas o cursor se mova em certas animações.
      easing_function = "linear", -- Tipo de animação (ex: "linear", "cubic", "quadratic").

      ---
      -- Título: Hooks (Ganchos)
      ---
      -- Funções que podem ser executadas antes (pre_hook) ou depois (post_hook) da animação.
      pre_hook = nil,
      post_hook = nil,
      performance_mode = true, -- Desativa a animação se o desempenho for um problema.
    })
  end,
}
