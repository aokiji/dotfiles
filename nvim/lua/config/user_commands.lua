-- GitlabURL
vim.api.nvim_create_user_command('GitlabURL', function()
  vim.fn.system(string.format('gitlab-url "%s" %d &> /dev/null', vim.fn.expand('%:p'), vim.fn.line('.')))
end, { nargs = 0 })

vim.api.nvim_create_user_command('GitlabOpenMerge', function()
  vim.fn.system(string.format('git open-merge "%s" &> /dev/null', vim.fn.expand('<cword>')))
end, { nargs = 0 })

vim.api.nvim_create_user_command('RedmineOpenTask', function()
  local issue_string = vim.fn.expand('<cword>')
  local issue = tonumber(issue_string)
  if issue ~= nil then
    vim.fn.system(string.format('open "https://redmine.intranet.meteologica.com/issues/%d" &> /dev/null',
      issue))
  else
    print(string.format('Invalid issue "%s", expected number', issue_string))
  end
end, { nargs = 0 })
