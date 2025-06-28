require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'slugbyte/unruly-worker.nvim'
end)

-- Use this setup config if you want to follow the keymap above
local unruly_worker = require('unruly-worker')

-- to setup with the defaults you can simply put
-- unruly_worker.setup()

-- example setup with the default settings
unruly_worker.setup({
  -- you can use the skip_list = {} to stop unruly from creating certain mappings
  -- skip_list = { "z", "Z", "<C-z>"},  skip z related mappings
  skip_list = {},
  unruly_options = {
    -- set default unruly kopy register must be [a-z] [A-Z] 0 +
    kopy_reg = "+",
    -- set default unruly macro register must be [a-z] [A-Z]
    macro_reg = "q",
    -- set default unruly seek mode, must be unruly_worker.seek_mode.(buffer|loclist|quickfix)
    seek_mode = unruly_worker.seek_mode.buffer,
    -- set unruly mark mode to global or local
    mark_mode_is_global = false
  },
  -- boosters allow you to op-in to extra keymaps
  -- or opt-out of the default keymaps if you want that for some reason
  booster = {
    default                     = true,
    -- easy stuff are just additional opt in keymaps
    easy_swap                   = false,
    easy_search = false,
    easy_line                   = false,
    easy_spellcheck             = false,
    easy_incrament              = false,
    easy_hlsearch               = false,
    easy_focus                  = false,
    easy_window                 = false,
    easy_jumplist               = false,
    easy_scroll                 = false,
    easy_source                 = false,
    easy_lsp                    = false,
    easy_lsp_leader             = false,
    easy_diagnostic             = false,
    easy_diagnostic_leader      = false,
    -- unruly stuff change neovim's normal behavior
    unruly_seek                 = false,
    unruly_mark                 = false,
    unruly_macro                = false,
    unruly_kopy                 = false,
    unruly_quit                 = false,
    -- plugin stuff have external dependencies
    plugin_navigator            = false,
    plugin_comment              = false,
    plugin_luasnip              = false,
    plugin_textobject           = false,
    plugin_telescope_leader     = false,
    plugin_telescope_lsp_leader = false,
    plugin_telescope_easy_jump  = false,
    plugin_telescope_easy_paste = false,
    plugin_telescope_diagnostic_leader = false,
  },
})
