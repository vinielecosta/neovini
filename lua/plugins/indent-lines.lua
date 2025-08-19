-- ~/.config/nvim/lua/plugins/indent-lines.lua
-- Este ficheiro configura o indent-blankline.nvim, um plugin que adiciona
-- guias de indentação verticais ao editor, tornando a estrutura de
-- aninhamento do código muito mais clara e fácil de seguir.

return {
  "lukas-reineke/indent-blankline.nvim",
  -- 'main' e 'opts' são configurações do lazy.nvim para otimização,
  -- garantindo que o plugin seja carregado de forma eficiente.
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      ---
      -- Título: Aparência das Linhas de Indentação
      ---
      indent = {
        -- Define o caractere a ser usado para a linha de indentação.
        -- O caractere '│' é uma linha vertical fina e discreta.
        char = "│",
        -- Usa o mesmo caractere para guias de tabulação.
        tab_char = "│",
      },
      ---
      -- Título: Destaque do Escopo Atual
      ---
      -- A funcionalidade 'scope' destaca a guia de indentação do bloco
      -- de código atual, facilitando a visualização do escopo.
      scope = {
        enabled = true,
        -- Desativa os marcadores no início e no fim do escopo para um visual mais limpo.
        show_start = false,
        show_end = false,
      },
    })
  end,
}
