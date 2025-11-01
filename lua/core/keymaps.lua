local keymap = vim.keymap.set

----------------------------------------------------------------------
-- NORMAL MODE (n)
----------------------------------------------------------------------

keymap('n', '<C-s>', ':w<CR>', {
    desc = 'Save file'
})

keymap('n', '<C-h>', '<C-w>h', {
    desc = 'Move to left window'
})
keymap('n', '<C-j>', '<C-w>j', {
    desc = 'Move to bottom window'
})
keymap('n', '<C-k>', '<C-w>k', {
    desc = 'Move to top window'
})
keymap('n', '<C-l>', '<C-w>l', {
    desc = 'Move to right window'
})

keymap('n', '<C-Up>', ':resize +2<CR>', {
    desc = 'Increase window height'
})
keymap('n', '<C-Down>', ':resize -2<CR>', {
    desc = 'Decrease window height'
})
keymap('n', '<C-Left>', ':vertical resize -2<CR>', {
    desc = 'Decrease window width'
})
keymap('n', '<C-Right>', ':vertical resize +2<CR>', {
    desc = 'Increase window width'
})

keymap('n', '<leader>q', ':q<CR>', {
    desc = 'Close current buffer'
})

keymap('n', '<leader>fa', ':set foldmethod=indent<CR>', {
    desc = 'Collapse code by indent'
})

-- keymap('n', '<leader>tt', function()
--     require('core.dotnet.dotnet-test').run_tests_from_solution()
-- end, {
--     desc = '.NET: Run project tests'
-- })

-- [T]este por [T]este ou [T]este de [C]lasse
-- Roda o teste mais próximo do cursor (pode ser um método ou uma classe)
keymap("n", "<leader>tt", function()
    require("neotest").run.run()
end, {
    desc = "Neotest: Rodar teste mais próximo (Teste/Classe)"
})

-- [T]este de [S]olução (Suite)
-- Roda todos os testes encontrados pelo adaptador (graças ao 'use_solution_scope = true')
keymap("n", "<leader>ts", function()
    require("neotest").run.run({
        suite = true
    })
end, {
    desc = "Neotest: Rodar toda a suíte (Solução)"
})

-- [T]este de [F]ile (Arquivo)
-- Roda todos os testes no arquivo atual
keymap("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
end, {
    desc = "Neotest: Rodar testes do arquivo atual"
})

-- [T]este [L]ast (Último)
-- Roda novamente o último teste executado
keymap("n", "<leader>tl", function()
    require("neotest").run.run_last()
end, {
    desc = "Neotest: Rodar último teste"
})

-- [T]este [O]utput (Saída)
-- Abre/fecha o painel de saída do último teste
keymap("n", "<leader>to", function()
    require("neotest").output.open()
end, {
    desc = "Neotest: Abrir painel de saída"
})

-- [T]este [S]ummary (Sumário)
-- Abre/fecha a janela de sumário dos testes
keymap("n", "<leader>tS", function()
    require("neotest").summary.toggle()
end, {
    desc = "Neotest: Abrir/Fechar sumário"
})

keymap('n', '<leader>rp', function()
    require('core.dotnet.dotnet-run').run_project()
end, {
    desc = '.NET: Run specific project'
})

keymap('n', '<leader>na', function()
    require('core.dotnet.add-package').add_package_directly()
end, {
    desc = 'NuGet: Add package directly'
})

keymap('n', '<leader>pr', function()
    require('core.dotnet.add-reference').add_project_reference()
end, {
    desc = '.NET: Add project reference'
})

keymap('n', '<leader>dn', function()
    require('core.dotnet.dotnet-new').create_project()
end, {
    desc = '.NET: Create new project'
})

keymap('n', '<leader>s', function()
    require('core.functions.find_replace').find_and_replace()
end, {
    desc = 'Find and Replace in file'
})

keymap('n', '<leader>z', ':ZenMode<CR>', {
    desc = 'Enable Zen mode'
})

keymap('n', '<leader>tw', ':Twilight<CR>', {
    desc = 'Enable Twilight mode'
})

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {
    desc = 'Open/Close File Explorer'
})

keymap('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic'
})
keymap('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic'
})

keymap('n', 'gD', vim.lsp.buf.declaration, {
    desc = 'LSP: Go to declaration'
})
keymap('n', 'gd', vim.lsp.buf.definition, {
    desc = 'LSP: Go to definition'
})
keymap('n', 'K', vim.lsp.buf.hover, {
    desc = 'LSP: Show hover documentation'
})
keymap('n', 'gi', vim.lsp.buf.implementation, {
    desc = 'LSP: Go to implementation'
})

keymap('n', '<leader>ca', function()
    vim.cmd('write')
    vim.lsp.buf.code_action()
end, {
    desc = 'LSP: Show code actions'
})

keymap('n', 'gr', vim.lsp.buf.references, {
    desc = 'LSP: Show references'
})
keymap('n', '<leader>rn', vim.lsp.buf.rename, {
    desc = 'LSP: Rename symbol'
})
keymap('n', '<leader>ft', function()
    vim.lsp.buf.format({
        async = true
    })
end, {
    desc = 'LSP: Format code'
})

keymap('n', '<leader>rr', function()
    vim.cmd('Roslyn restart')
end, {
    desc = 'LSP: Restart Roslyn Server'
})

keymap("n", "<leader>jf", '<cmd>JsonFormatFile<cr>', {
    desc = 'JSON: Format file'
})
keymap("n", "<leader>jmf", '<cmd>JsonMinifyFile<cr>', {
    desc = 'JSON: Minify file'
})

keymap('n', '<leader>vt', '<Cmd>ToggleTerm direction=vertical<CR>', {
    desc = 'Toggle terminal vertically'
})

keymap('n', '<leader>ht', '<Cmd>ToggleTerm direction=horizontal<CR>', {
    desc = 'Toggle terminal horizontally'
})

keymap('n', '<C-a>', '<Cmd>Alpha<CR>', {
    desc = 'Show Alpha'
})

keymap('n', '<leader>tw', ':Twilight<CR>', {
    desc = 'Twilight mode'
})

keymap('n', '<M-l>', 'zL', {
    desc = 'Scroll Right Half-Screen'
}) -- Alt + L
keymap('n', '<M-h>', 'zH', {
    desc = 'Scroll Left Half-Screen'
})

----------------------------------------------------------------------
-- VISUAL MODE (v)
----------------------------------------------------------------------

keymap('v', '<', '<gv', {
    desc = 'Indent left (keep selection)'
})
keymap('v', '>', '>gv', {
    desc = 'Indent right (keep selection)'
})

----------------------------------------------------------------------
-- INSERT MODE (i)
----------------------------------------------------------------------

keymap('i', 'jk', '<ESC>', {
    desc = 'Exit insert mode'
})

keymap('i', '<C-H>', '<C-W>', {
    noremap = true,
    desc = 'Binding delete on "Ctrl + Backspace'
})

keymap('i', '<C-Right>', '<Esc>ea', {
    desc = 'Move to end of word'
})
keymap('i', '<C-Left>', '<Esc>bi', {
    desc = 'Move to beginning of word'
})

----------------------------------------------------------------------
-- TERMINAL MODE (t)
----------------------------------------------------------------------

keymap('t', '<C-t>', '<Cmd>ToggleTerm<CR>', {
    desc = 'Hide terminal'
})

