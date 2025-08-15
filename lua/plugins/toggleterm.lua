-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
    'akinsho/toggleterm.nvim',
    version = "*",
    -- A propriedade 'keys' define os atalhos que carregarão o plugin sob demanda
    keys = {{
        '<leader>ft',
        "<cmd>ToggleTerm direction=float<CR>",
        desc = "Terminal Flutuante"
    }, {
        '<leader>vt',
        "<cmd>ToggleTerm direction=vertical<CR>",
        desc = "Terminal Vertical"
    }, {
        '<leader>st',
        "<cmd>ToggleTerm direction=horizontal<CR>",
        desc = "Terminal Horizontal"
    }, {
        '<leader>gg',
        "<cmd>ToggleTerm direction=float cmd=lazygit<CR>",
        desc = "LazyGit"
    }},
    -- 'config' ainda é usado para configurar o comportamento do plugin
    config = function()
        require('toggleterm').setup({
            close_on_exit = true,
            start_in_insert = true,

            -- ADICIONE ESTA LINHA PARA ESPECIFICAR O POWERSHELL
            shell = "pwsh",

            direction = 'float', -- Direção padrão se nenhuma for especificada
            float_opts = {
                border = 'rounded'
            }
        })
    end
}
