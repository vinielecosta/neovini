-- ~/.config/nvim/lua/plugins/alpha-dashboard.lua
return {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        -- GERAÇÃO DO ASCII ART "NeoVini :]"
        -- Você pode gerar outros em: https://patorjk.com/software/taag/#p=display&f=Standard&t=NeoVini%20%3A%5D
        local header = {[[ _______             ____   ____.__       .__       ____.]],
                        [[ \      \   ____  ___\   \ /   /|__| ____ |__| /\  |_   |]],
                        [[ /   |   \_/ __ \/  _ \   Y   / |  |/    \|  | \/    |  |]],
                        [[/    |    \  ___(  <_> )     /  |  |   |  \  | /\    |  |]],
                        [[\____|__  /\___  >____/ \___/   |__|___|  /__| \/   _|  |]],
                        [[        \/     \/                       \/         |____|]]}

        -- BOTÕES DE AÇÃO ESSENCIAIS
        dashboard.section.buttons.val = {dashboard.button("f", "󰍉 Buscar arquivo", ":Telescope find_files <CR>"),
                                         dashboard.button("p", "󱊓 Buscar projeto", ":Telescope find_files <CR>"),
                                         dashboard.button("r", "󰏌 Arquivos recentes", ":Telescope oldfiles <CR>"),
                                         dashboard.button("g", "󰍄 Buscar texto", ":Telescope live_grep <CR>"),
                                         dashboard.button("l", "󰒇 Lazy", ":Lazy <CR>"),
                                         dashboard.button("q", "󰅚 Sair", ":qa<CR>")}

        -- FRASES EM "MINEIRÊS" PARA O RODAPÉ
        local fortunes = {"Uai, sô! Bão demais da conta", "Pão de queijo quentim é trem bão",
                          "Nó, que doideira, sô!", "Arreda pra lá, trem!", "Vou te contar um causo...",
                          "Fica siô, vai ter café e broa", "Cê tá bão?", "Queijo com goiabada, não tem erro",
                          "Esse café tá bão, hein!"}

        -- Função que seleciona uma frase aleatoriamente
        local function get_fortune()
            local index = math.random(1, #fortunes)
            return "💬 " .. fortunes[index]
        end

        dashboard.section.footer.val = get_fortune()

        -- Define o cabeçalho com o nosso ASCII Art
        dashboard.section.header.val = header

        -- Adiciona um espaçamento entre os botões
        dashboard.section.buttons.opts.spacing = 1
        dashboard.section.footer.opts.hl = "Type"

        -- Aplica o layout
        alpha.setup(dashboard.opts)
    end
}
