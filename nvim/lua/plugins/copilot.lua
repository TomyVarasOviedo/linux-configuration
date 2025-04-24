return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  config = function()
    -- Configuración básica
    vim.g.codeium_no_map_tab = 1 -- Desactiva el mapeo de <Tab> por defecto
  end,
}
