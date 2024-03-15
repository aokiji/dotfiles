return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {},
    tag = 'v2.20.8' -- forced as version 3 breaks
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() vim.cmd.colorscheme 'catppuccin-mocha' end },
  -- { -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function() vim.cmd.colorscheme 'onedark' end
  -- },
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    -- See `:help lualine.txt`
    opts = { options = { icons_enabled = true, theme = 'catppuccin', component_separators = '|', section_separators = '' } }
  }, -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      local whichkey = require('which-key')
      whichkey.setup(opts)

      local mappings = {
        ['Q'] = { "<cmd>qa!<cr>", "Quit All" },
        ['O'] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline Toggle" },
        b = { name = "File Browser", },
        t = { name = 'Test', f = { "<cmd>TestFile<cr>", "[T]est [F]ile" }, l = { "<cmd>TestLast<cr>", "[T]est [L]ast" } },
        d = { name = "Debugger", },
        g = { name = "Git", },
        l = { name = "LSP" },
        r = { name = "Redmine", o = { "<cmd>RedmineOpenTask<cr>", "Open Redmine Task" }, },
        s = { name = "Search" },
        x = { name = "Trouble" }
      }
      whichkey.register(mappings, { prefix = "<leader>" })
    end
  }, -- Present a dashboard on start up
  {
    'goolord/alpha-nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require 'alpha'.setup(require 'alpha.themes.startify'.config) end
  },
  {
    -- notification manager
    'rcarriga/nvim-notify',
    init = function()
      vim.notify = require("notify")
    end,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", function() require("trouble").toggle() end,                        desc = 'Toggle Trouble' },
      { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = 'Trouble Workspace Diagnostics' },
      { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = 'Trouble Document Diagnostics' },
      { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = 'Trouble Quickfix' },
      { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = 'Trouble Loclist' },
      { "gR",         function() require("trouble").toggle("lsp_references") end,        desc = 'Trouble Lsp References' }
    }
  }
}
