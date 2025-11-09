require("dashboard").setup({
  theme = "hyper",
  disable_move = true,
  change_to_vcs_root = true,
  hide = {
    statusline = false,
    tabline = true,
    winbar = true,
  },
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {},
    packages = { enable = false, },
    footer = {},
  },
})
