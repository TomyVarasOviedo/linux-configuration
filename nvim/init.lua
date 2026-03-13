-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.commands")
require("config.keymaps")

-- Color scheme
vim.o.background = "dark"
vim.cmd([[colorscheme neofusion]])

-- Java Configuration
-- require("java").setup()
-- require("lspconfig").jdtls.setup({})

-- Configuracion de incline --
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")
require("incline").setup({
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    if filename == "" then
      filename = "[No Name]"
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local modified = vim.bo[props.buf].modified
    return {
      ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
      " ",
      { filename, gui = modified and "bold,italic" or "bold" },
      " ",
      guibg = "#44406e",
    }
  end,
})
-- Configuracion de Incline --
-- Configuracion de Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Configuracion de ToggleTerm
-- Toggle Term Configuration
require("toggleterm").setup({
  autodir = true, -- Colocarse en la ruta de una caperta automaticamente
  open_mapping = [[<C-S-ñ>]],
  direction = "float",
  size = 25,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
})

-- Configuracion de Toggle Comment
require("Comment").setup()
