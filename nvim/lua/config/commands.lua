local M = {}
--FUNCIONES DE COMANDOS--
function M.RunPython()
  local current_file = vim.fn.expand("%") -- Ruta del archivo actual
  -- Verificar si es un archivo .py
  if not current_file:match("%.py$") then
    vim.notify("❌ No es un archivo Python (.py)", vim.log.levels.ERROR)
    return
  end
  -- Crear un buffer flotante
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8) -- 80% del ancho
  local height = math.floor(vim.o.lines * 0.6) -- 60% del alto

  -- Opciones de la ventana flotante
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded", -- Borde estilizado
  }

  -- Abrir la ventana
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Comando a ejecutar (python3 + archivo actual)
  local cmd = "python3 " .. vim.fn.shellescape(current_file)

  -- Ejecutar en terminal embebido
  vim.fn.termopen(cmd, {
    on_exit = function()
      -- Opcional: Cerrar ventana al finalizar (descomentar si se desea)
      -- vim.schedule(function()
      --     vim.api.nvim_win_close(win, true)
      -- end)
    end,
  })

  -- Entrar en modo inserción automáticamente
  vim.cmd("startinsert")
end

function M.RunRust()
  local current_file = vim.fn.expand("%") -- Ruta del archivo actual

  if not current_file:match("%.rs$") then
    vim.notify("❌ No es un archivo Rust (.rs)", vim.log.levels.ERROR)
    return
  end
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8) -- 80% del ancho
  local height = math.floor(vim.o.lines * 0.6)
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded", -- Borde estilizado
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  local cmd = "cargo run " -- Comando para ejecutar Rust
  vim.fn.termopen(cmd, {
    on_exit = function()
      -- Opcional: Cerrar ventana al finalizar (descomentar si se desea)
      -- vim.schedule(function()
      --     vim.api.nvim_win_close(win, true)
      -- end)
    end,
  })
  vim.cmd("startinsert")
end
-- COMANDOS --
vim.api.nvim_create_user_command("PythonRun", M.RunPython, {
  desc = "Ejecutar archivo Python (.py)",
})

vim.api.nvim_create_user_command("RunRust", M.RunRust, {
  desc = "Ejecutar archivo Rust (.rs)",
})

return M
