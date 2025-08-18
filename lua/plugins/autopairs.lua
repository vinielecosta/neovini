-- ~/.config/nvim/lua/plugins/autopairs.lua
return {
    'windwp/nvim-autopairs',
    event = "InsertEnter", -- Carrega o plugin assim que você entra no modo de inserção
    config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup({
            -- Não adiciona um par se já houver um caractere "não-palavra" na frente
            check_ts = true,
            -- Adiciona um espaço extra ao criar pares para construções como { }
            ts_config = {
                lua = {'string'},
                javascript = {'template_string'},
                java = false
            }
        })

        -- Integração com nvim-cmp para que o autocompletar funcione bem
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
}
