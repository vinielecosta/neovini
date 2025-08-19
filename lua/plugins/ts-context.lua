-- ~/.config/nvim/lua/plugins/ts-context.lua
-- Este ficheiro configura o nvim-treesitter-context, um plugin que melhora
-- a navegação em ficheiros longos. Ele exibe o "contexto" do seu código atual
-- (ex: o nome da classe e do método) no topo do ecrã quando a definição
-- original sai da vista, similar ao "Sticky Scroll" do VS Code.

return {
  'nvim-treesitter/nvim-treesitter-context',
  -- Dependências: Garante que o nvim-treesitter seja carregado, pois este plugin depende dele.
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('treesitter-context').setup({
      ---
      -- Título: Configuração Principal
      ---
      enable = true, -- Ativa o plugin.
      max_lines = 3, -- Número máximo de linhas de contexto a serem exibidas.
      min_window_height = 10, -- Altura mínima da janela para o contexto ser ativado.
      line_numbers = true, -- Mostra os números das linhas no contexto.
      trim_scope = 'outer', -- Define como o escopo é cortado.

      ---
      -- Título: Aparência
      ---
      -- Define o caractere a ser usado como separador entre as linhas de contexto.
      separator = '─',
    })
  end,
}
