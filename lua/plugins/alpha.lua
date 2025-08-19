-- ~/.config/nvim/lua/plugins/alpha-dashboard.lua
-- Este ficheiro configura o ecrã de boas-vindas (dashboard) que aparece
-- ao iniciar o Neovim, utilizando o plugin alpha-nvim.

return {
  'goolord/alpha-nvim',
  -- O evento 'VimEnter' garante que o ecrã de boas-vindas seja a primeira coisa a aparecer.
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Necessário para os ícones dos botões.
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    ---
    -- Título: Cabeçalho (ASCII Art)
    ---
    -- Define o texto em arte ASCII que aparecerá no topo do ecrã.
    -- Gerado em: https://patorjk.com/software/taag/
    local header = {
      [[ _______            ____   ____.__       .__       ____.]],
      [[ \      \   ____  ___\   \ /   /|__| ____ |__| /\   |_   |]],
      [[ /   |   \_/ __ \/  _ \   Y   / |  |/    \|  | \/    |   |]],
      [[/    |    \  ___(  <_> )     /  |  |   |  \  | /\    |   |]],
      [[\____|__  /\___  >____/ \___/   |__|___|  /__| \/   _|   |]],
      [[         \/     \/                      \/          |____|]],
    }

    ---
    -- Título: Botões de Ação
    ---
    -- Define os botões interativos que aparecerão no menu principal.
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰍉  Buscar arquivo", ":Telescope find_files <CR>"),
      dashboard.button("p", "󱊓  Buscar projeto", ":Telescope project <CR>"), -- Corrigido para usar a extensão de projeto
      dashboard.button("r", "󰏌  Arquivos recentes", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "󰍄  Buscar texto", ":Telescope live_grep <CR>"),
      dashboard.button("l", "󰒇  Lazy", ":Lazy <CR>"),
      dashboard.button("q", "󰅚  Sair", ":qa<CR>"),
    }

    ---
    -- Título: Rodapé (Frases Aleatórias)
    ---
    -- Lista de frases em "mineirês" para serem exibidas aleatoriamente.
    local fortunes = {
      "Uai, sô! Bão demais da conta.",
      "Pão de queijo quentim é trem bão.",
      "Nó, que doideira, sô!",
      "Arreda pra lá, trem!",
      "Vou te contar um causo...",
      "Fica siô, vai ter café e broa.",
      "Cê tá bão?",
      "Queijo com goiabada, não tem erro.",
      "Esse café tá bão, hein!",
    }

    -- Função que seleciona uma frase aleatoriamente da lista.
    local function get_fortune()
      local index = math.random(1, #fortunes)
      return "💬 " .. fortunes[index]
    end

    -- Define o conteúdo do cabeçalho e do rodapé.
    dashboard.section.header.val = header
    dashboard.section.footer.val = get_fortune()

    ---
    -- Título: Opções de Layout
    ---
    -- Ajusta a aparência do dashboard.
    dashboard.section.buttons.opts.spacing = 1 -- Espaçamento entre os botões.
    dashboard.section.footer.opts.hl = "Type" -- Grupo de destaque para o texto do rodapé.

    -- Aplica todas as configurações de layout ao alpha.
    alpha.setup(dashboard.opts)
  end,
}
