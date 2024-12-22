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
        { "<leader>O",  "<cmd>SymbolsOutline<cr>",  desc = "Symbols Outline Toggle" },
        { "<leader>Q",  "<cmd>qa!<cr>",             desc = "Quit All" },
        { "<leader>b",  group = "File Browser" },
        { "<leader>d",  group = "Debugger" },
        { "<leader>g",  group = "Git" },
        { "<leader>l",  group = "LSP" },
        { "<leader>q",  "<cmd>q<cr>",               desc = "Quit" },
        { "<leader>r",  group = "Redmine" },
        { "<leader>ro", "<cmd>RedmineOpenTask<cr>", desc = "Open Redmine Task" },
        { "<leader>s",  group = "Search" },
        { "<leader>t",  group = "Test" },
        { "<leader>x",  group = "Trouble" },
      }
      whichkey.add(mappings)
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
    opts = { auto_preview = false },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      { "gR", function() require("trouble").toggle("lsp_references") end, desc = 'Trouble Lsp References' }
    }
  },
  -- better vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    opts = {}
  }
}
