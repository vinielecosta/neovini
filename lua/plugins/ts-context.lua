-- ~/.config/nvim/lua/plugins/ts-context.lua
return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
        require('treesitter-context').setup({
            enable = true,
            max_lines = 3,
            min_window_height = 10,
            line_numbers = true,
            trim_scope = 'outer',

            -- CORREÇÃO: Trocamos '---' por um caractere de linha único
            separator = '─'
        })
    end
}
