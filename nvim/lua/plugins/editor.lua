return {

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      local actions = require('telescope.actions')
      local trouble = require("trouble.sources.telescope")

      return {
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ["<c-t>"] = trouble.open
            },
            n = { ["<c-t>"] = trouble.open },
          }
        },
        pickers = {
          buffers = { ignore_current_buffer = true, sort_lastused = true },
          git_status = {
            mappings = {
              i = {
                ["<cr>"] = require('telescope.actions').git_staging_toggle,
                ["<C-c>"] = function(prompt_bufnr)
                  actions.close(prompt_bufnr)
                  vim.cmd.Git()
                end
              }
            }
          }
        }
      }
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)

      local builtin = require('telescope.builtin')
      local nmap = function(mapping, action, desc) vim.keymap.set('n', mapping, action, { desc = desc }) end

      nmap('<leader>?', builtin.oldfiles, '[?] Find recently opened files')
      nmap('<leader><space>', builtin.buffers, '[ ] Find existing buffers')
      nmap('<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end, '[/] Fuzzily search in current buffer')

      nmap('<leader>ss', builtin.builtin, 'Telescope')
      nmap('<leader>sf', builtin.find_files, '[S]earch [F]iles')
      nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
      nmap('<leader>st', builtin.tags, '[S]earch [T]ags')
      nmap('<leader>sT', builtin.current_buffer_tags, '[S]earch Buffer[T]ags')
      nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
      nmap('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
      nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      nmap('<leader>sj', builtin.jumplist, '[S]earch [J]umplist')
      nmap('<leader>so', builtin.oldfiles, '[S]earch [O]ldfiles')
      nmap('<leader>sq', builtin.quickfix, '[S]earch [Q]uickfix')
      nmap('<leader>sr', builtin.registers, '[S]earch [R]egisters')


      -- Git keymaps
      nmap('<leader>gS', builtin.git_status, '[G]it [S]tatus picker')
      nmap('<leader>gB', builtin.git_branches, '[G]it [B]ranches picker')

      local redmine_issues_picker = function(opts)
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local actions = require('telescope.actions')
        local action_state = require "telescope.actions.state"

        opts = opts or {}
        pickers.new(opts, {
          prompt_title = 'Redmine Issues',
          results_title = 'Ctrl+o to open issue in browser',
          finder = finders.new_oneshot_job({ "redmine_issues" }, opts),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function()
            actions.select_default:replace(function(prompt_bufnr)
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local line = selection[1]
              local issue_id = line:match("^([^\t]+)")
              vim.api.nvim_put({ issue_id }, "", false, true)
            end)
            vim.keymap.set({ "i", "n" }, "<c-o>", function()
              local selection = action_state.get_selected_entry()
              local line = selection[1]
              local issue_id = line:match("^([^\t]+)")
              vim.fn.system(string.format('open https://redmine.intranet.meteologica.com/issues/"%s" &> /dev/null',
                issue_id))
            end)
            return true
          end,
        }):find()
      end
      nmap('<leader>ri', redmine_issues_picker, 'Open redmine issues list')
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
    requires = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeFocus' },
    keys = {
      { '<leader>bt', "<cmd>NvimTreeToggle<cr>",   desc = "Browser Toggle" },
      { '<leader>bs', "<cmd>NvimTreeFindFile<cr>", desc = "Select file in browser" },
      { '<leader>bf', "<cmd>NvimTreeFocus<cr>",    desc = "Focus on browser" }
    },
    opts = {}
  }, -- tmux navigation
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require 'nvim-tmux-navigation'.setup {
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
