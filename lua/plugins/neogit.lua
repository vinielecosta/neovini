-- ~/.config/nvim/lua/plugins/neogit.lua
return {
    'NeogitOrg/neogit',
    dependencies = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim'},
    -- O atalho <leader>gg já está configurado no ficheiro de keymaps
    -- para o lazygit, vamos mantê-lo para o Neogit.
    keys = {{
        "<leader>gp",
        function()
            require("neogit").open()
        end,
        desc = "Neogit"
    }},
    config = true
}
