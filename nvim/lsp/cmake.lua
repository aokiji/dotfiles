return {
  -- el servidor ha sido instalado manualmente, mason falla porque intenta usar python -m venv y no funciona correctamente en el sistema
  -- lo que si funciona es uv venv
  cmd = { vim.fn.expand('~/.cmake-language-server/venv/bin/cmake-language-server') },
}
