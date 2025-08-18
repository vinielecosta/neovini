-- ~/.config/nvim/lua/plugins/smooth-scroll.lua
return {
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup({
            -- Adicione quaisquer mapeamentos que você queira animar
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
            hide_cursor = true,
            stop_eof = true,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            easing_function = "quadratic", -- Efeito de animação
            pre_hook = nil,
            post_hook = nil,
            performance_mode = false
        })
    end
}
