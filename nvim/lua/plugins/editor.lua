return {
  {
    'echasnovski/mini.pick',
    version = '*',
    opts = function()
      local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW',
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end
      return {
        window = { config = win_config },
        mappings = {
          move_down  = '<C-j>',
          move_start = '<C-g>',
          move_up    = '<C-k>',
        }
      }
    end,
    keys = function(plugin)
      -- usar readtags para listar las etiquetas
      local function pick_ctags()
        --- @type __pick_builtin_opts
        local source_config = {
          source = {
            choose = function(item)
              local fname = item.fname
              local ex_cmd = item.ex_cmd
              if fname and ex_cmd then
                vim.api.nvim_win_call(
                  MiniPick.get_picker_state().windows.target,
                  function()
                    vim.cmd('edit ' .. fname)
                    vim.cmd(ex_cmd)
                  end
                )
              end
            end
          }
        }
        local config = vim.tbl_deep_extend('force', source_config, plugin.opts())

        MiniPick.builtin.cli({
          command = { 'readtags', '-l' },
          postprocess = function(items)
            return vim.tbl_map(function(line)
              local fields = vim.split(line, "\t")
              local tag, fname, ex_cmd = fields[1], fields[2], fields[3]
              return {
                text = string.format("%-30s %s", tag, fname or ""),
                fname = fname,
                ex_cmd = ex_cmd
              }
            end, items)
          end,
        }, config)
      end
      return {
        { '<leader>pf',       '<cmd>Pick files<cr>',                   desc = "Pick a file" },
        { '<leader>pg',       '<cmd>Pick grep_live<cr>',               desc = "Pick from grep" },
        { '<leader>ph',       '<cmd>Pick help<cr>',                    desc = "Pick from help" },
        { '<leader>pb',       '<cmd>Pick buffers<cr>',                 desc = "Pick from buffers" },
        { '<leader><leader>', '<cmd>Pick buffers<cr>',                 desc = "Pick from buffers" },
        { '<leader>pw',       "<cmd>:Pick grep pattern='<cword>'<cr>", desc = "Pick from current word" },
        { '<leader>pt',       pick_ctags,                              desc = "Pick from ctags" }
      }
    end,
    cmd = 'Pick'
  },
  {
    'nvim-mini/mini.extra',
    version = '*',
    keys = function()
      local pickers = require('mini.extra').pickers
      return {
        { '<leader>pB', pickers.git_branches,                                              desc = "Pick a git branch" },
        { '<leader>pd', pickers.diagnostic,                                                desc = "Pick from diagnostics" },
        { '<leader>pc', pickers.git_hunks,                                                 desc = "Pick from git hunks" },
        { '<leader>pL', pickers.buf_lines,                                                 desc = "Pick from buffer lines" },
        { '<leader>pq', function() return pickers.list({ scope = 'quickfix' }) end,        desc = "Pick from quickfix" },
        { '<leader>pj', function() return pickers.list({ scope = 'jump' }) end,            desc = "Pick from jumplist" },
        { '<leader>ps', function() return pickers.lsp({ scope = 'document_symbol' }) end,  desc = "Pick from LSP document symbol" },
        { '<leader>pS', function() return pickers.lsp({ scope = 'workspace_symbol' }) end, desc = "Pick from LSP workspace symbol" },
        { '<leader>pr', pickers.registers,                                                 desc = "Pick from registers" },
        { '<leader>pT', pickers.treesitter,                                                desc = "Pick from treesitter" },
      }
    end
  },
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
      nmap('<leader>sp', require 'telescope'.extensions.projects.projects, '[S]earch [P]rojects')


      -- Git keymaps
      nmap('<leader>gS', builtin.git_status, '[G]it [S]tatus picker')
      nmap('<leader>gB', builtin.git_branches, '[G]it [B]ranches picker')
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
    'nvim-mini/mini.files',
    version = '*',
    keys = function()
      local MiniFiles = require('mini/files')
      return {
        { '<leader>bo', MiniFiles.open,                                              desc = "Open File Browser" },
        { '<leader>bs', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "Open Current File in Browser" }
      }
    end,
  },
  -- tmux navigation
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
  },
  {
    "ggandor/leap.nvim",
    opts = { safe_labels = {} },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
    end,
  }
}
