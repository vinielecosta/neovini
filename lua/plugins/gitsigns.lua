-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Este ficheiro configura o gitsigns.nvim, um plugin que mostra as alterações
-- do Git (linhas adicionadas, modificadas, removidas) diretamente na calha
-- (a coluna à esquerda dos números das linhas).

return {
  'lewis6991/gitsigns.nvim',
  -- O evento 'VeryLazy' garante que o plugin só seja carregado quando necessário,
  -- otimizando o tempo de arranque do Neovim.
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup({
      ---
      -- Título: Sinais Visuais
      ---
      -- Define os ícones que aparecerão na calha para cada tipo de alteração.
      -- Requer uma Nerd Font para serem exibidos corretamente.
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '▎' },
      },
      ---
      -- Título: Atalhos de Teclado (on_attach)
      ---
      -- Função que é executada para cada ficheiro que o gitsigns "anexa".
      -- É o local ideal para definir os atalhos de teclado do plugin.
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local keymap = vim.keymap.set

        -- Opções padrão para os atalhos (aplicam-se apenas a este buffer).
        local opts = { buffer = bufnr }

        ---
        -- Subtítulo: Navegação entre Alterações (Hunks)
        ---
        -- Permite saltar rapidamente entre os blocos de código que foram alterados.
        keymap('n', ']h', function() gs.next_hunk() end, opts)
        keymap('n', '[h', function() gs.prev_hunk() end, opts)

        ---
        -- Subtítulo: Ações sobre Hunks
        ---
        -- Permite adicionar ao stage ou reverter blocos de código específicos.
        keymap('n', '<leader>hs', gs.stage_hunk, opts) -- Adiciona o hunk atual ao stage.
        keymap('n', '<leader>hr', gs.reset_hunk, opts) -- Reverte as alterações do hunk atual.
        -- As mesmas ações, mas para uma seleção no Modo Visual.
        keymap('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
        keymap('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)

        ---
        -- Subtítulo: Ações sobre o Ficheiro Inteiro (Buffer)
        ---
        keymap('n', '<leader>hS', gs.stage_buffer, opts) -- Adiciona todas as alterações do ficheiro ao stage.
        keymap('n', '<leader>hR', gs.reset_buffer, opts) -- Reverte todas as alterações no ficheiro.

        ---
        -- Subtítulo: Ações de Visualização
        ---
        -- Mostra as alterações do hunk atual numa janela flutuante.
        keymap('n', '<leader>hp', gs.preview_hunk, opts)
        -- Mostra quem foi o autor da alteração da linha atual (git blame).
        keymap('n', '<leader>hb', function() gs.blame_line({ full = true }) end, opts)
      end,
    })
  end,
}
