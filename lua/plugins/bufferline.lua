-- ~/.config/nvim/lua/plugins/bufferline.lua
-- Este ficheiro configura o bufferline.nvim, o plugin que cria uma barra de abas (tabs)
-- no topo do editor para mostrar e gerir os ficheiros abertos (buffers).

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons', -- Necessário para os ícones dos tipos de ficheiro.
  config = function()
    require("bufferline").setup({
      ---
      -- Título: Opções de Comportamento e Aparência
      ---
      options = {
        -- Mostra os diagnósticos (erros, avisos) do LSP diretamente na aba do ficheiro.
        diagnostics = "nvim_lsp",

        -- Mostra um ícone 'X' para fechar cada aba.
        show_buffer_close_icons = true,
        show_close_icon = true,

        -- Garante que a barra de abas esteja sempre visível, mesmo que apenas um ficheiro esteja aberto.
        always_show_bufferline = true,
      },
      ---
      -- Título: Configuração de Destaques (Highlights) e Transparência
      ---
      -- Esta secção força a transparência da barra de abas, garantindo que ela herde
      -- o efeito acrílico do terminal, independentemente do tema.
      highlights = {
        -- Define o fundo principal da barra como transparente.
        fill = {
          bg = "NONE"
        },
        -- Define o fundo das abas individuais como transparente.
        background = {
          bg = "NONE"
        },
      },
    })

    ---
    -- Título: Atalhos de Teclado para Navegação
    ---
    -- Define atalhos para navegar rapidamente entre as abas.
    local keymap = vim.keymap.set
    -- Shift + L para ir para a próxima aba.
    keymap('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = "Buffer Seguinte" })
    -- Shift + H para ir para a aba anterior.
    keymap('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = "Buffer Anterior" })
  end,
}
