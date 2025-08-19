-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
    'akinsho/toggleterm.nvim',
    version = "*",
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
    }, {
        '<esc>',
        '<C-\\><C-n>',
        mode = '',
        desc = 'Sair do modo terminal'
    }},
    config = function()
        require('toggleterm').setup({
            close_on_exit = true,
            start_in_insert = true,
            shell = "pwsh",
            direction = 'float',
            float_opts = {
                border = 'rounded'
            }
        })
    end
}
