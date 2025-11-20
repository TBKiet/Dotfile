-- lua/plugins/lsp-inlayhints.lua
return {
  {
    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\\>]],
        shade_terminals = true,
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 3,
        },
      })

      -- Toggle a floating terminal with <leader>t
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    end,
  },
}
