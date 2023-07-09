return {

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = function()
      local actions = require('telescope.actions')

      return {
        defaults = {
          mappings = {i = {['<C-j>'] = actions.move_selection_next, ['<C-k>'] = actions.move_selection_previous}}
        },
        pickers = {buffers = {ignore_current_buffer = true, sort_lastused = true}}
      }
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)

      local builtin = require('telescope.builtin')
      local nmap = function(mapping, action, desc) vim.keymap.set('n', mapping, action, {desc = desc}) end

      nmap('<leader>?', builtin.oldfiles, '[?] Find recently opened files')
      nmap('<leader><space>', builtin.buffers, '[ ] Find existing buffers')
      nmap('<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {winblend = 10, previewer = false})
      end, {desc = '[/] Fuzzily search in current buffer'})

      nmap('<leader>sf', builtin.find_files, '[S]earch [F]iles')
      nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
      nmap('<leader>st', builtin.tags, '[S]earch [T]ags')
      nmap('<leader>sT', builtin.current_buffer_tags, '[S]earch Buffer[T]ags')
      nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
      nmap('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
      nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')

      -- Diagnostic keymaps
      nmap('[d', vim.diagnostic.goto_prev, "Go to previous diagnostic message")
      nmap(']d', vim.diagnostic.goto_next, "Go to next diagnostic message")
      nmap('<leader>e', vim.diagnostic.open_float, "Open floating diagnostic message")
      nmap('<leader>q', vim.diagnostic.setloclist, "Open diagnostics list")
    end
  }, -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end
  }, -- file explorer
  {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function() require("nvim-tree").setup {} end
  }, -- tmux navigation
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>"
        }
      }
    end
  }
}
