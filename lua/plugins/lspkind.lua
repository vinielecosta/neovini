-- ~/.config/nvim/lua/plugins/ui.lua
-- Este ficheiro inicializa e configura o plugin "neokinds", responsável por trazer pictogramas para completions do "csharp_ls".

return {
    'thebigcicca/neokinds',
    config = function()
        require('neokinds').setup({
            icons = {
                error = "",
                warn = "",
                hint = "",
                info = ""
            },
            completion_kinds = {
                Text = " ",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = " ",
                Field = "",
                Variable = " ",
                Class = "󰠱 ",
                Interface = " ",
                Module = " ",
                Property = "󰜢 ",
                Unit = " ",
                Value = " ",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                EnumMember = " ",
                Constant = " ",
                Struct = "",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
                Boolean = " ",
                Array = " "
            }
        })
    end
}
