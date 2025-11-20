return {
  -- Enhanced markdown keymaps and functionality
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    keys = {
      -- Toggle markdown rendering
      { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Rendering", ft = "markdown" },
      -- Enable/disable markdown rendering
      { "<leader>me", "<cmd>RenderMarkdown enable<cr>", desc = "Enable Markdown Rendering", ft = "markdown" },
      { "<leader>md", "<cmd>RenderMarkdown disable<cr>", desc = "Disable Markdown Rendering", ft = "markdown" },
    },
  },

  -- Markdown navigation and editing keymaps
  {
    "neovim/nvim-lspconfig",
    ft = "markdown",
    keys = {
      -- Header navigation
      { "]]", function()
        vim.cmd("silent! /^#\\+\\s")
      end, desc = "Next Header", ft = "markdown" },

      { "[[", function()
        vim.cmd("silent! ?^#\\+\\s")
      end, desc = "Previous Header", ft = "markdown" },

      -- List item operations
      { "<leader>ml", "o- ", desc = "New List Item", ft = "markdown", mode = "n" },
      { "<leader>mn", "o1. ", desc = "New Numbered Item", ft = "markdown", mode = "n" },
      { "<leader>mc", "o- [ ] ", desc = "New Checkbox Item", ft = "markdown", mode = "n" },

      -- Toggle checkbox
      { "<leader>mx", function()
        local line = vim.api.nvim_get_current_line()
        if line:match("- %[ %]") then
          vim.cmd("s/- \\[ \\]/- [x]/")
        elseif line:match("- %[x%]") then
          vim.cmd("s/- \\[x\\]/- [ ]/")
        end
      end, desc = "Toggle Checkbox", ft = "markdown" },

      -- Text formatting
      -- Bold
      { "<leader>mb", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          local s_start = vim.fn.getpos("'<")
          local s_end = vim.fn.getpos("'>")
          local line1, col1 = s_start[2]-1, s_start[3]-1
          local line2, col2 = s_end[2]-1, s_end[3]
          local lines = vim.api.nvim_buf_get_text(0, line1, col1, line2, col2, {})
          local text = table.concat(lines)
          vim.api.nvim_buf_set_text(0, line1, col1, line2, col2, { "**" .. text .. "**" })
        else
          local word = vim.fn.expand("<cword>")
          vim.cmd("normal! ciw")
          vim.api.nvim_put({ "**" .. word .. "**" }, "c", true, true)
        end
      end, desc = "Bold Text", ft = "markdown", mode = {"n", "v"} },

      -- Italic
      { "<leader>mi", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          local s_start = vim.fn.getpos("'<")
          local s_end = vim.fn.getpos("'>")
          local line1, col1 = s_start[2]-1, s_start[3]-1
          local line2, col2 = s_end[2]-1, s_end[3]
          local lines = vim.api.nvim_buf_get_text(0, line1, col1, line2, col2, {})
          local text = table.concat(lines)
          vim.api.nvim_buf_set_text(0, line1, col1, line2, col2, { "*" .. text .. "*" })
        else
          local word = vim.fn.expand("<cword>")
          vim.cmd("normal! ciw")
          vim.api.nvim_put({ "*" .. word .. "*" }, "c", true, true)
        end
      end, desc = "Italic Text", ft = "markdown", mode = {"n", "v"} },

      -- Inline Code
      { "<leader>mk", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          local s_start = vim.fn.getpos("'<")
          local s_end = vim.fn.getpos("'>")
          local line1, col1 = s_start[2]-1, s_start[3]-1
          local line2, col2 = s_end[2]-1, s_end[3]
          local lines = vim.api.nvim_buf_get_text(0, line1, col1, line2, col2, {})
          local text = table.concat(lines)
          vim.api.nvim_buf_set_text(0, line1, col1, line2, col2, { "`" .. text .. "`" })
        else
          local word = vim.fn.expand("<cword>")
          vim.cmd("normal! ciw")
          vim.api.nvim_put({ "`" .. word .. "`" }, "c", true, true)
        end
      end, desc = "Code Inline", ft = "markdown", mode = {"n", "v"} },

      -- Code block
      { "<leader>mC", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          local s_start = vim.fn.getpos("'<")
          local s_end = vim.fn.getpos("'>")
          local line1, col1 = s_start[2]-1, s_start[3]-1
          local line2, col2 = s_end[2]-1, s_end[3]
          local lines = vim.api.nvim_buf_get_text(0, line1, col1, line2, col2, {})
          local text = table.concat(lines, "\n")
          local code_block = "```\n" .. text .. "\n```"
          vim.api.nvim_buf_set_text(0, line1, col1, line2, col2, vim.split(code_block, "\n"))
        else
          local current_line = vim.api.nvim_get_current_line()
          local row = vim.api.nvim_win_get_cursor(0)[1]
          local code_lines = { "```", "", "```" }
          vim.api.nvim_buf_set_lines(0, row, row, false, code_lines)
          vim.api.nvim_win_set_cursor(0, {row + 2, 0})
        end
      end, desc = "Code Block", ft = "markdown", mode = {"n", "v"} },

      -- Links
      { "<leader>mL", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          local s_start = vim.fn.getpos("'<")
          local s_end = vim.fn.getpos("'>")
          local line1, col1 = s_start[2]-1, s_start[3]-1
          local line2, col2 = s_end[2]-1, s_end[3]
          local lines = vim.api.nvim_buf_get_text(0, line1, col1, line2, col2, {})
          local text = table.concat(lines)
          local link = "[" .. text .. "]()"
          vim.api.nvim_buf_set_text(0, line1, col1, line2, col2, { link })
          -- Position cursor inside the parentheses
          vim.api.nvim_win_set_cursor(0, {line1 + 1, col1 + #text + 3})
        else
          local word = vim.fn.expand("<cword>")
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          vim.cmd("normal! ciw")
          local link = "[" .. word .. "]()"
          vim.api.nvim_put({ link }, "c", true, true)
          -- Position cursor inside the parentheses
          vim.api.nvim_win_set_cursor(0, {row, col + #word + 2})
        end
      end, desc = "Create Link", ft = "markdown", mode = {"n", "v"} },

      -- Headers
      { "<leader>m1", "I# <Esc>", desc = "Header 1", ft = "markdown" },
      { "<leader>m2", "I## <Esc>", desc = "Header 2", ft = "markdown" },
      { "<leader>m3", "I### <Esc>", desc = "Header 3", ft = "markdown" },
      { "<leader>m4", "I#### <Esc>", desc = "Header 4", ft = "markdown" },

      -- Table operations
      { "<leader>mT", function()
        local lines = {
          "| Header 1 | Header 2 | Header 3 |",
          "|----------|----------|----------|",
          "|          |          |          |"
        }
        vim.api.nvim_put(lines, "l", true, true)
      end, desc = "Insert Table", ft = "markdown" },
    },
  },

  -- Additional markdown tools
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview", ft = "markdown" },
      { "<leader>mP", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview", ft = "markdown" },
    },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "「${name}」"
    end,
  },
}
