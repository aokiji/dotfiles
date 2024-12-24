vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

vim.filetype.add({
  pattern = {
    [".*%.pg"] = "sql"
  }
})

vim.filetype.add({
  pattern = {
    [".*%.sls"] = "sls"
  }
})
