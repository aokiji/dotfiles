return {
  -- cmd = { "cargo", "run", "--bin", "postgrestools", "lsp-proxy", "--log-path", "/tmp/postgres_lsp.log" },
  cmd = { "postgrestools", "lsp-proxy", "--log-path", "/tmp/postgres_lsp.log"}
  -- cmd_cwd = "/home/nicolas.delossantos/workspace/postgres-language-server",
}
