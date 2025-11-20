return {
  -- Disable nvim-lint for markdown
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {}, -- disable all linters
      },
    },
  },
  -- Disable markdown-preview from LazyVim extra to avoid conflict
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Ensure render-markdown is enabled
      enabled = true,
    },
  },
  -- Example in your lazy.nvim setup (e.g., in init.lua or a dedicated plugins file)
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lang.markdown", -- Ensure this line is present
      },
    },
  },
  -- -- Disable LSP diagnostics in markdown
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     setup = {
  --       marksman = function(_, _)
  --         vim.api.nvim_create_autocmd("FileType", {
  --           pattern = "markdown",
  --           callback = function()
  --             vim.diagnostic.disable(0)
  --           end,
  --         })
  --         return true -- still attach if needed (e.g., for hover, completion)
  --       end,
  --     },
  --   },
  -- },
  -- -- Disable formatting on markdown if desired
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       markdown = {}, -- disable formatters
  --     },
  --   },
  -- },
}
