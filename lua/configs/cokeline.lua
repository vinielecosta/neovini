-- ~/.config/nvim/lua/configs/cokeline.lua
require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  
  default_hl = {
    bg = function(buffer)
      local hlgroups = require("cokeline.hlgroups")
      return buffer.is_focused and hlgroups.get_hl_attr("ColorColumn", "bg")
        or "#181616" -- Buffer color when unfocused
    end,
  }
})  