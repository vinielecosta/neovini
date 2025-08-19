-- ~/.config/nvim/lua/plugins/ui.lua
-- Este ficheiro agrupa os plugins responsáveis pela interface do utilizador (UI),
-- como o explorador de ficheiros, notificações e a linha de comandos.

return {
  ----------------------------------------------------------------------
  -- Título: Explorador de Ficheiros (Nvim-Tree)
  ----------------------------------------------------------------------
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        -- Ordena os ficheiros de forma sensível a maiúsculas/minúsculas.
        sort_by = 'case_sensitive',
        -- Configurações da janela do explorador.
        view = {
          width = 30, -- Largura da janela em colunas.
        },
        -- Configurações de renderização.
        renderer = {
          group_empty = true, -- Mostra pastas vazias.
        },
        -- Filtros para ocultar ficheiros.
        filters = {
          dotfiles = false, -- Mostra ficheiros ocultos (ex: .gitignore).
        },
        -- Configura a ação de apagar para mover ficheiros para a lixeira.
        trash = {
          cmd = "trash", -- Requer um utilitário de lixeira de linha de comando.
        },
      })
      -- Mapeamento para abrir/fechar o Nvim-Tree.
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Abrir/Fechar File Explorer' })
    end,
  },

  ----------------------------------------------------------------------
  -- Título: Componentes Visuais da UI
  ----------------------------------------------------------------------
  -- Ícones para a UI: Fornece ícones para tipos de ficheiro no Nvim-Tree e outros plugins.
  { 'nvim-tree/nvim-web-devicons' },

  -- Notificações: Substitui as notificações padrão do Neovim por pop-ups mais bonitos.
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000',
      })
    end,
  },

  -- Noice.nvim: Melhora a UI para mensagens, linha de comandos e pop-ups.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = function()
      require("noice").setup({
        -- Melhora a renderização de documentação do LSP.
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- Predefinições para uma experiência de UI mais moderna.
        presets = {
          bottom_search = true, -- Mantém a barra de pesquisa no rodapé.
          command_palette = true, -- Cria uma paleta de comandos ao estilo VS Code.
          long_message_to_split = true, -- Mostra mensagens longas numa nova janela.
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
}
