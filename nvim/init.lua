-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("java").setup()
require("lspconfig").jdtls.setup({})
require("config.commands")
-- require("maven").setup({
--  executable = "mvn", -- `mvn` should be in your `PATH`, or the path to the maven exectable, for example `./mvnw`
--  cwd = nil, -- work directory, default to `vim.fn.getcwd()`
--  settings = nil, -- specify the settings file or use the default settings
--  commands = { -- add custom goals to the command list
--    { cmd = { "clean", "compile" }, desc = "clean then compile" },
--  },
--})

-- Toggle Term Configuration
require("toggleterm").setup({
  autodir = true, -- Colocarse en la ruta de una caperta automaticamente
  open_mapping = [[<C-S-ñ>]],
  direction = "float",
  size = 36,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
})
