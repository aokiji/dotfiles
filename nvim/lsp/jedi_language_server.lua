return {
  -- el servidor ha sido instalado manualmente, mason falla porque intenta usar python -m venv y no funciona correctamente en el sistema
  -- lo que si funciona es uv venv
  cmd = { vim.fn.expand('~/.jedi-language-server/venv/bin/jedi-language-server') },
  init_options = { workspace = { environmentPath = vim.fn.expand('~/.local/bin/python') } }
}
