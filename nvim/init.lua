local project_path = vim.fn.expand('<sfile>:p:h')
vim.opt.rtp:append(project_path)

require('config').setup()

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
    lazypath
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  performance = {
    rtp = {
      reset = false
    }
  },
  lockfile = project_path .. "/lazy-lock.json"
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
