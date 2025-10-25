require("which-key").setup({
    notify = false,
    plugins = {
        marks = true, -- Mostra pop-up para marcas (ex: 'a)
        registers = true, -- Mostra pop-up para registradores (ex: "a)
        spelling = {
            enabled = true, -- Mostra sugestões de correção ortográfica (ex: z=)
            suggestions = 20
        }
    },
    window = {
        border = "single", -- Estilo da borda da janela: 'none', 'single', 'double', 'rounded'
        position = "bottom" -- Posição da janela: 'bottom', 'top'
    },
    layout = {
        spacing = 3, -- Espaçamento entre as colunas
        align = "center" -- Alinhamento do texto
    }
})
