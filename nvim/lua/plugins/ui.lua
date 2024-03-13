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
        ['B'] = { "<cmd>Git blame<cr>", "Git blame" },
        ['U'] = { "<cmd>GitlabURL<cr>", "Open file in Gitlab" },
        ['Q'] = { "<cmd>qa<cr>", "Quit All" },
        ['O'] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline Toggle" },
        b = {
          name = "Browser",
          t = { "<cmd>NvimTreeToggle<cr>", "Browser Toggle" },
          s = { "<cmd>NvimTreeFindFile<cr>", "Select file in browser" },
          f = { "<cmd>NvimTreeFocus<cr>", "Focus on browser" }
        },
        a = { name = "ALE", f = { "<cmd>ALEFix<cr>", "ALE Fix" } },
        t = { name = 'Test', f = { "<cmd>TestFile<cr>", "[T]est [F]ile" }, l = { "<cmd>TestLast<cr>", "[T]est [L]ast" } },
        d = {
          name = "Debugger",
          c = { "<cmd>lua require('dap').continue()<cr>", "Debugger [c]ontinue" },
          b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Debugger toggle [b]reakpoint" },
          r = { "<cmd>lua require('dap').run_last()<cr>", "Debugger [r]un last" },
          e = { "<cmd>lua require('dap').repl.open()<cr>", "Debugger [e]val console" },
          v = { "<cmd>lua require('dapui').toggle()<cr>", "Debugger [v]iew toggle" }
        },
        g = {
          name = "Git",
          b = { "<cmd>Git blame<cr>", "Git blame" },
          s = { "<cmd>Git<cr>", "Git status" },
          u = { "<cmd>GitlabURL<cr>", "Open file in Gitlab" },
          o = { "<cmd>GitlabOpenMerge<cr>", "Open merge in Gitlab" },
          l = { "<cmd>Git log %<cr>", "Show git log of current file" },
          p = { "<cmd>Git push -u origin HEAD<cr>", "Git push" },
          P = { "<cmd>Git push --force<cr>", "Git force push" },
        },
        o = {
          name = "Open",
          r = { "<cmd>RedmineOpenTask<cr>", "Open Redmine Task" },
          g = { "<cmd>GitlabURL<cr>", "Open file in Gitlab" },
        }
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
    'rcarriga/nvim-notify'
  }
}
