-- ~/.config/nvim/lua/plugins/ts-context.lua
-- Este ficheiro configura o nvim-treesitter-context, um plugin que melhora
-- a navegação em ficheiros longos. Ele exibe o "contexto" do seu código atual
-- (ex: o nome da classe e do método) no topo do ecrã quando a definição
-- original sai da vista, similar ao "Sticky Scroll" do VS Code.

return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('treesitter-context').setup({
      enable = true,
      max_lines = 3,
      min_window_height = 10,
      line_numbers = true,
      trim_scope = 'outer',
      separator = '─',
    })

    -- Altera a cor do separador para um cinza claro
    vim.cmd("highlight TreesitterContextSeparator guifg=#DCDCDC guibg=NONE")

  end,
}
