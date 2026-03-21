-- GitlabURL
vim.api.nvim_create_user_command('GitlabURL', function()
  vim.fn.system(string.format('gitlab-url "%s" %d &> /dev/null', vim.fn.expand('%:p'), vim.fn.line('.')))
end, { nargs = 0 })

vim.api.nvim_create_user_command('GitlabOpenMerge', function()
  vim.fn.system(string.format('git open-merge "%s" &> /dev/null', vim.fn.expand('<cword>')))
end, { nargs = 0 })

vim.api.nvim_create_user_command('GitlabOpenCommit', function()
  vim.fn.system(string.format('git open-commit "%s" &> /dev/null', vim.fn.expand('<cword>')))
end, { nargs = 0 })

vim.api.nvim_create_user_command('RedmineOpenTask', function()
  local issue_string = vim.fn.expand('<cword>')
  local issue = tonumber(issue_string)
  if vim.g.redmine_url == nil then
    local file = io.open(vim.fn.expand("~/.config/redmine/url"), "r")
    if file then
      vim.g.redmine_url = file:read("a")
      file.close()
    else
      vim.notify("No se pudo leer el fichero de configuracion de la url del redmine", vim.log.levels.WARN)
    end
  end
  if issue ~= nil and vim.g.redmine_url ~= nil then
    vim.fn.system(string.format('open "%s/issues/%d" &> /dev/null',
      vim.g.redmine_url, issue))
  else
    print(string.format('Invalid issue "%s", expected number', issue_string))
  end
end, { nargs = 0 })
