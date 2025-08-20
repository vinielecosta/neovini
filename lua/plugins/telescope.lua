-- ~/.config/nvim/lua/plugins/telescope.lua
-- Este ficheiro configura o telescope.nvim, um plugin de busca "fuzzy"
-- altamente extensível. Ele é usado para procurar ficheiros, texto, buffers,
-- referências de código e muito mais.

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Biblioteca de utilidades Lua.
  lazy = false, -- O carregamento preguiçoso afeta a inicialização do plugin e dos atalhos. Para melhor experiência, é melhor não usar lazy loading aqui.
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    ---
    -- Título: Configuração Principal do Telescope
    ---
    telescope.setup({
      -- Configurações padrão que se aplicam a todos os seletores (pickers).
      defaults = {
        -- Exibe os caminhos dos ficheiros de forma inteligente (relativos ao diretório de trabalho).
        path_display = { "smart" },
        -- Ativa a quebra de linha para resultados longos, melhorando a legibilidade.
        wrap_results = true,

        ---
        -- Subtítulo: Atalhos de Teclado Dentro do Telescope
        ---
        mappings = {
          -- Mapeamentos para o modo de inserção (quando se está a digitar a busca).
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- Move a seleção para cima.
            ['<C-j>'] = actions.move_selection_next,     -- Move a seleção para baixo.
            ['<CR>'] = actions.select_default,         -- Abre a seleção na janela atual.
            ['<C-x>'] = actions.select_vertical,       -- Abre a seleção num split vertical.
            ['<C-s>'] = actions.select_horizontal,     -- Abre a seleção num split horizontal.
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- Envia para a quickfix list.
          },
        },
        
        ---
        -- Subtítulo: Configuração de Destaques e Transparência
        ---
        -- Garante que o fundo do Telescope seja transparente, herdando o efeito do terminal.
        highlights = {
          TelescopeNormal = { link = "Normal" },
          TelescopeBorder = { link = "Normal" },
        },
      },
      ---
      -- Título: Configurações Específicas de Seletores (Pickers)
      ---
      pickers = {
        -- Customiza o seletor de referências do LSP.
        lsp_references = {
          -- Oculta a linha de código na lista de resultados, mostrando apenas o caminho do ficheiro.
          show_line = false,
        },
      },
    })

    ---
    -- Título: Atalhos de Teclado Globais para o Telescope
    ---
    -- Define os atalhos para abrir os seletores mais comuns do Telescope.
    local keymap = vim.keymap.set
    keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Buscar Arquivos' })
    keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Buscar por Texto (Grep)' })
    keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buscar em Buffers Abertos' })
    keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Buscar na Ajuda' })
  end,
}
