return {
  cmd = { vim.fn.expand('~/workspace/sqls/sqls'), '-l', '/tmp/sqls.log' },
  init_options = {
    connectionConfig = {
      alias = 'pg_local',
      driver = 'postgresql',
      dataSourceName = 'postgres://eolica@localhost:5432/eolica'
    }
    -- connectionConfig = {
    --   alias = 'pg_local_test',
    --   driver = 'postgresql',
    --   dataSourceName = 'postgres://example_user:example_password@localhost:15432/example_db'
    -- }
  }
}
