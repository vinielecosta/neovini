-- ~/.config/nvim/lua/plugins/neogit.lua
-- Este ficheiro configura o Neogit, um plugin que fornece uma interface
-- de utilizador completa para o Git, inspirada no Magit do Emacs.
-- Permite realizar operações como stage, commit, push, pull e ver o histórico
-- de forma visual e interativa, sem sair do Neogit.

return {
  'NeogitOrg/neogit',
  -- Dependências: Outros plugins que o Neogit utiliza para funcionalidades extra.
  dependencies = {
    'nvim-lua/plenary.nvim',      -- Uma biblioteca de utilidades Lua usada por muitos plugins.
    'sindrets/diffview.nvim',     -- Usado para uma visualização de "diffs" (diferenças) mais avançada.
    'nvim-telescope/telescope.nvim', -- Integração com o Telescope para buscas.
  },
  ---
  -- Título: Atalho de Teclado
  ---
  -- Define o atalho para abrir a interface do Neogit.
  -- Usar a propriedade 'keys' do lazy.nvim garante que o plugin só seja
  -- carregado na primeira vez que o atalho for pressionado.
  keys = {
    {
      "<leader>gp", -- O atalho é Espaço + g + p (Git Popup)
      function()
        require("neogit").open()
      end,
      desc = "Neogit", -- Descrição que aparecerá na paleta de comandos.
    },
  },
  -- 'config = true' é um atalho do lazy.nvim que simplesmente executa
  -- require("neogit").setup() com as configurações padrão do plugin.
  config = true,
}
