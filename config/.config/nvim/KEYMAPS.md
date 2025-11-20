# Neovim Keymaps

Tài liệu tổng hợp tất cả phím tắt được định nghĩa trong cấu hình Neovim này.

> Ghi chú: file và mô tả lấy từ các kê khai `vim.keymap.set` và cấu hình plugin trong thư mục `lua/`.

---

## Tổng quan

- Vị trí cấu hình chính: `lua/config/keymaps.lua`, `lua/plugins/*.lua`.
- Một số mapping được thiết lập chỉ khi LSP attach (có ghi chú `buffer = buffer`).

---

## Phím tắt (thu thập tự động)

### `lua/config/keymaps.lua`

- Mode: n (normal) — Key: `<leader>td`
  - Mô tả: Toggle diagnostics for current file (bật/tắt diagnostics cho buffer hiện tại)
  - Hành động: bật/tắt `vim.diagnostic` cho buffer hiện tại và hiển thị thông báo

- Mode: n (normal) — Key: `<leader>tv`
  - Mô tả: Toggle diagnostics virtual text (ẩn/hiện virtual text của diagnostics)
  - Hành động: thay đổi `vim.diagnostic.config({ virtual_text = ... })` và thông báo

### `lua/plugins/example.lua`

- Mode: n (normal) — Key: `<leader>co`
  - Mô tả: Organize Imports (TypeScript) — chỉ được đăng ký khi LSP attach và buffer tương ứng
  - Hành động: thực thi `TypescriptOrganizeImports` (plugin `typescript.nvim`)
  - Note: có cờ `{ buffer = buffer }` — mapping local cho buffer

- Mode: n (normal) — Key: `<leader>cR`
  - Mô tả: Rename File (TypeScript) — chỉ khi LSP attach và cho buffer
  - Hành động: thực thi `TypescriptRenameFile`
  - Note: `{ buffer = buffer }`

### `lua/plugins/setting.lua` (commented)

- Mode: n (normal) — Key: `<leader>r` (bị comment)
  - Mô tả: Run Python file (mở terminal và chạy file hiện tại) — đang comment

---

## Mappings mặc định (LazyVim)

LazyVim có tập hợp keymap mặc định được load tự động. Tham khảo: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

---

## Gợi ý

- Để thêm mô tả cho mapping mới, dùng tham số `desc` trong `vim.keymap.set` — các plugin như which-key sẽ hiển thị mô tả này.
- Để mapping chỉ cho buffer, thêm `{ buffer = bufnr }`.

---

## Phân loại theo plugin

Phần này gom các phím tắt theo plugin hoặc nhóm tính năng để dễ tham khảo.

- Core (cấu hình của bạn)
  - `<leader>td` (n) — Toggle diagnostics for current file (tắt/bật diagnostics cho buffer hiện tại) — `lua/config/keymaps.lua`
  - `<leader>tv` (n) — Toggle diagnostics virtual text (ẩn/hiện virtual text) — `lua/config/keymaps.lua`

- Telescope
  - `<leader>fp` (n) — Find Plugin File (mở `telescope.builtin.find_files` trong thư mục plugin) — `lua/plugins/example.lua`

- TypeScript / typescript.nvim
  - `<leader>co` (n, buffer-local) — Organize Imports (`TypescriptOrganizeImports`) — đăng ký khi LSP attach — `lua/plugins/example.lua`
  - `<leader>cR` (n, buffer-local) — Rename File (`TypescriptRenameFile`) — đăng ký khi LSP attach — `lua/plugins/example.lua`

- Trouble
  - `folke/trouble.nvim` được cấu hình trong `lua/plugins/example.lua` (được thay đổi `opts` nhưng sau đó còn có một spec disabled). Không có mapping tuỳ chỉnh rõ ràng trong repo này.

- ToggleTerm (bị comment)
  - `<leader>r` (n) — Run Python file (mapping comment trong `lua/plugins/setting.lua`) — hiện đang comment

- Which-Key
  - `which-key.nvim` xuất hiện trong `lazy-lock.json` (plugin được cài) — nếu active, nó sẽ hiển thị `desc` của các mapping có mô tả.

---

## Next steps

- Nếu bạn muốn, mình có thể:
  - Quét thêm để tìm mappings trong toàn bộ home config (nếu bạn muốn bao gồm cả plugin mặc định của LazyVim)
  - Tạo phần phân loại theo plugin (telescope, trouble, etc.)
  - Commit file này vào git repository và/hoặc mở PR

---

## LazyVim defaults (selected)

Dưới đây là một số mapping mặc định phổ biến được LazyVim cung cấp (trích chọn từ `lua/lazyvim/config/keymaps.lua`). Đây chỉ là lựa chọn — file gốc chứa nhiều mapping hơn.

- Di chuyển/Scroll:
  - `j`, `k` (n, x) — Up/Down thông minh (đi theo display lines khi không có count) — LazyVim
  - `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` (n) — Move to window (left/down/up/right)

- Resize windows:
  - `<C-Up>`, `<C-Down>`, `<C-Left>`, `<C-Right>` — Resize window

- Buffers:
  - `<S-h>`, `<S-l>` (n) — Prev/Next buffer
  - `<leader>bb` / `<leader>\`` — Switch to other buffer
  - `<leader>bd`, `<leader>bo`, `<leader>bD` — Delete buffer variants

- Search / View:
  - `<esc>` (i/n/s) — Clear search and stop snippet (custom behavior)
  - `<leader>ur` — Redraw / Clear hlsearch / Diff Update
  - `n`, `N` (n/x/o) — Improved next/prev search result behavior

- File & Editing helpers:
  - `<C-s>` (i, x, n, s) — Save file
  - `<leader>fn` — New file
  - `<leader>cf` (n, v) — Format (LazyVim.format)

- Diagnostics:
  - `<leader>cd` — Line Diagnostics (open float)
  - `]d`, `[d` — Next/Prev Diagnostic
  - `]e`, `[e` — Next/Prev Error
  - `]w`, `[w` — Next/Prev Warning

- Git / Lazy:
  - `<leader>l` — Open Lazy
  - `<leader>gg`, `<leader>gG` — Lazygit (if executable)
  - `<leader>gL`, `<leader>gb`, `<leader>gf`, `<leader>gl` — Git log / blame / file history

- Toggles (Snacks):
  - `<leader>ud`, `<leader>ul`, `<leader>us`, `<leader>uw`, ... — Various toggles (diagnostics, line numbers, spell, wrap, etc.)

- Windows / Tabs:
  - `<leader>-`, `<leader>|` — Split window below/right
  - `<leader>wd` — Delete window
  - `<leader><tab>...` — Tab navigation (`<leader><tab>l`, `<leader><tab>o`, `<leader><tab>f`, ...)

Nguồn đầy đủ: [LazyVim keymaps](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)

