-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- Toggle diagnostics for the current buffer
vim.keymap.set("n", "<leader>td", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local is_disabled = vim.diagnostic.is_disabled(bufnr)
  if is_disabled then
    vim.diagnostic.enable(bufnr)
    vim.notify("Diagnostics enabled", vim.log.levels.INFO)
  else
    vim.diagnostic.disable(bufnr)
    vim.notify("Diagnostics disabled for this file", vim.log.levels.WARN)
  end
end, { desc = "Toggle diagnostics for current file" })

-- Toggle diagnostics virtual text (the inline warning/error text)
vim.keymap.set("n", "<leader>tv", function()
  local config = vim.diagnostic.config()
  local current = config.virtual_text
  if type(current) == "table" or current == true then
    vim.diagnostic.config({ virtual_text = false })
    vim.notify("Virtual text hidden", vim.log.levels.WARN)
  else
    vim.diagnostic.config({ virtual_text = { spacing = 2, prefix = "●" } })
    vim.notify("Virtual text shown", vim.log.levels.INFO)
  end
end, { desc = "Toggle diagnostics virtual text" })
