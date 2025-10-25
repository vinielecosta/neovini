require("neotest").setup({
    -- Configuração do adaptador .NET
    adapters = {require("neotest-dotnet")({
        -- Especifique seu framework de teste. Pode ser "xunit", "nunit", ou "mstest".
        test_adapter = "xunit",

        -- !! IMPORTANTE para o seu pedido de "Soluções" !!
        -- Isso faz o adaptador procurar o arquivo .sln mais próximo
        -- e rodar os testes a partir do nível da solução.
        use_solution_scope = true,

        -- Argumentos extras para o comando `dotnet test`
        dotnet_test_args = {"--nologo", "-v=q"}
    })},
    -- Configurações visuais (opcional, mas recomendado)
    status = {
        virtual_text = true
    },
    output = {
        open_on_run = true -- Abrir painel de saída ao rodar
    },
    summary = {
        open = "rightbelow vsplit" -- Abrir sumário em um split vertical
    }
})
