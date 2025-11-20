return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang_format" },
      c = { "clang_format" },
      python = { "black" },
    },
    formatters = {
      clang_format = {
        command = vim.fn.stdpath("data") .. "/mason/bin/clang-format",
      },
      black = {
        command = vim.fn.stdpath("data") .. "/mason/bin/black",
      },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
