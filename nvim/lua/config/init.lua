local M = {}

function M.setup()
  require('config.keymaps')
  require('config.options')
  require('config.autocmds')
  require('config.filetypes')
  require('config.user_commands')
end

return M
