let g:ale_fixers['ruby'] = ['rubocop']
let g:ale_linters['ruby'] = ['rubocop', 'reek', 'ruby']

nmap fs :set paste<cr>i# frozen_string_literal: true<cr><cr><esc>:set nopaste<cr>
