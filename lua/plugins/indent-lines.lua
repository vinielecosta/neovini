-- ~/.config/nvim/lua/plugins/indent-lines.lua
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup({
            indent = {
                char = "│",
                tab_char = "│"
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false
            }
        })
    end
}
