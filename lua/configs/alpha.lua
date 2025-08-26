local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

---
-- Title: Header (ASCII Art)
---
-- Defines the ASCII art text that will appear at the top of the screen.
-- Generated at: https://patorjk.com/software/taag/
local header = {
  [[ _______            ____   ____.__       .__       ____.]],
  [[ \      \   ____  ___\   \ /   /|__| ____ |__| /\   |_   |]],
  [[ /   |   \_/ __ \/  _ \   Y   / |  |/    \|  | \/    |   |]],
  [[/    |    \  ___(  <_> )     /  |  |   |  \  | /\    |   |]],
  [[\____|__  /\___  >____/ \___/   |__|___|  /__| \/   _|   |]],
  [[         \/     \/                      \/          |____|]],
}

---
-- Title: Action Buttons
---
-- Defines the interactive buttons that will appear in the main menu.
dashboard.section.buttons.val = {
  dashboard.button("f", "󰍉  Find file", ":Telescope find_files <CR>"),
  dashboard.button("p", "󱊓  Find project", ":Telescope project <CR>"),
  dashboard.button("r", "󰏌  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("g", "󰍄  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("l", "󰒇  Lazy", ":Lazy <CR>"),
  dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
}

---
-- Title: Footer (Random Phrases)
---
-- List of phrases in "mineirês" to be displayed randomly.
local fortunes = {
  "Uai, sô! Bão demais da conta.",
  "Pão de queijo quentim é trem bão.",
  "Nó, que doideira, sô!",
  "Arreda pra lá, trem!",
  "Vou te contar um causo...",
  "Fica siô, vai ter café e broa.",
  "Cê tá bão?",
  "Queijo com goiabada, não tem erro.",
  "Esse café tá bão, hein!",
}

-- Function that randomly selects a phrase from the list.
local function get_fortune()
  local index = math.random(1, #fortunes)
  return "💬 " .. fortunes[index]
end

-- Sets the header and footer content.
dashboard.section.header.val = header
dashboard.section.footer.val = get_fortune()

---
-- Title: Layout Options
---
-- Adjusts the dashboard appearance.
dashboard.section.buttons.opts.spacing = 1 -- Spacing between buttons.
dashboard.section.footer.opts.hl = "Type" -- Highlight group for footer text.

-- Applies all layout settings to alpha.
alpha.setup(dashboard.opts)
