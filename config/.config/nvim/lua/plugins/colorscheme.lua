return {
  "folke/tokyonight.nvim",
  lazy = false, -- Set to false to ensure the plugin loads immediately
  priority = 1000, -- High priority to load colorscheme early
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
}
-- return {
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = function()
--         require("catppuccin").load()
--       end,
--     },
--   },
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     opts = {
--       no_italic = true,
--       term_colors = true,
--       transparent_background = false,
--       styles = {
--         comments = {},
--         conditionals = {},
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--       },
--       color_overrides = {
--         mocha = {
--           base = "#000000",
--           mantle = "#000000",
--           crust = "#000000",
--         },
--       },
--       integrations = {
--         telescope = {
--           enabled = true,
--           style = "nvchad",
--         },
--         dropbar = {
--           enabled = true,
--           color_mode = true,
--         },
--       },
--     },
--   },
-- }
