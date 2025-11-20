# 📝 Markdown Keymaps Reference

Tài liệu tham khảo đầy đủ các phím tắt để làm việc hiệu quả với Markdown trong Neovim.

> 📍 **File cấu hình**: `lua/plugins/markdown-keymaps.lua`
> 🎯 **Scope**: Chỉ hoạt động trong file có filetype `markdown`

---

## 🎨 Render Controls

Điều khiển việc hiển thị markdown với `render-markdown.nvim`:

| Keymap | Mô tả | Chức năng |
|--------|-------|-----------|
| `<leader>mt` | Toggle Markdown Rendering | Bật/tắt rendering markdown |
| `<leader>me` | Enable Markdown Rendering | Bật rendering markdown |
| `<leader>md` | Disable Markdown Rendering | Tắt rendering markdown |

---

## 🧭 Navigation

Di chuyển nhanh trong document markdown:

| Keymap | Mô tả | Chức năng |
|--------|-------|-----------|
| `]]` | Next Header | Nhảy đến header tiếp theo |
| `[[` | Previous Header | Nhảy về header trước đó |

**💡 Tip**: Sử dụng để navigate nhanh giữa các section trong document dài.

---

## 📋 List Operations

Tạo và quản lý các loại list:

| Keymap | Mô tả | Kết quả | Ví dụ |
|--------|-------|---------|-------|
| `<leader>ml` | New List Item | `- ` | Bullet point |
| `<leader>mn` | New Numbered Item | `1. ` | Numbered list |
| `<leader>mc` | New Checkbox Item | `- [ ] ` | Todo checkbox |
| `<leader>mx` | Toggle Checkbox | `[ ]` ↔ `[x]` | Check/uncheck |

### 🔄 Checkbox Workflow:
1. `<leader>mc` → Tạo checkbox mới
2. Nhập nội dung task
3. `<leader>mx` → Toggle completed/pending

---

## ✨ Text Formatting

Format text nhanh chóng (hỗ trợ cả Normal và Visual mode):

| Keymap | Mô tả | Markdown Output | Modes |
|--------|-------|-----------------|-------|
| `<leader>mb` | Bold Text | `**text**` | `n`, `v` |
| `<leader>mi` | Italic Text | `*text*` | `n`, `v` |
| `<leader>mk` | Inline Code | `` `code` `` | `n`, `v` |
| `<leader>mL` | Create Link | `[text](url)` | `n`, `v` |

### 📝 Cách sử dụng:
- **Normal mode**: Cursor trên từ → keymap → format từ đó
- **Visual mode**: Select text → keymap → format vùng được chọn

---

## 📑 Document Structure

Tạo headers và khối code:

| Keymap | Mô tả | Output |
|--------|-------|--------|
| `<leader>m1` | Header 1 | `# ` |
| `<leader>m2` | Header 2 | `## ` |
| `<leader>m3` | Header 3 | `### ` |
| `<leader>m4` | Header 4 | `#### ` |
| `<leader>mC` | Code Block | ``` ``` |

---

## 📊 Table Operations

Tạo table nhanh chóng:

| Keymap | Mô tả | Kết quả |
|--------|-------|---------|
| `<leader>mT` | Insert Table | Table 3x3 với headers |

### 📋 Table Template:
```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
|          |          |          |
```

---

## 👀 Preview & Export

Xem trước markdown trong browser:

| Keymap | Mô tả | Plugin |
|--------|-------|--------|
| `<leader>mp` | Markdown Preview | `markdown-preview.nvim` |
| `<leader>mP` | Stop Markdown Preview | Đóng preview |

### ⚙️ Preview Settings:
- Auto-close khi đóng buffer
- Sync scroll với editor
- Ẩn YAML frontmatter
- Support Math (KaTeX), Mermaid diagrams

---

## 🚀 Workflow Examples

### ✅ Todo List Workflow:
```
<leader>mc  → - [ ] Task 1
<leader>mc  → - [ ] Task 2
<leader>mx  → - [x] Task 1 (completed)
```

### 📖 Document Structure:
```
<leader>m1  → # Main Title
<leader>m2  → ## Section 1
<leader>m3  → ### Subsection
```

### 💻 Code Documentation:
```
<leader>mk  → `function_name`
<leader>mC  →
```python
def hello():
    print("world")
```

### 🔗 Link Creation:
```
Visual select "GitHub" → <leader>mL → [GitHub](url)
```

---

## 🎯 Tips & Best Practices

### 🔥 Power User Tips:
1. **Combine với Telescope**: `<leader>ff` → tìm markdown files nhanh
2. **Use với Copilot**: Các keymaps tương thích với AI completion
3. **Git workflow**: Works well với `gitsigns.nvim` để track changes
4. **LSP Integration**: `marksman` LSP cung cấp hover, completion

### 🎨 Render-markdown Features:
- Syntax highlighting cho code blocks
- Icon cho checkboxes và bullets
- Math equation rendering
- Callout boxes (note, warning, etc.)

### ⚡ Performance:
- Chỉ load khi filetype = markdown
- Lazy loading với LazyVim
- Không ảnh hưởng performance files khác

---

## 🔧 Customization

Để tùy chỉnh thêm keymaps, edit file `lua/plugins/markdown-keymaps.lua`:

```lua
-- Thêm keymap mới
{ "<leader>m5", "I##### <Esc>", desc = "Header 5", ft = "markdown" },
```

### 🎨 Render-markdown Config:
Tùy chỉnh trong `lua/plugins/markdownlint.lua`:
```lua
opts = {
  headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  code = { enabled = true, style = "full" },
}
```

---

## 📚 Related Files

| File | Mục đích |
|------|----------|
| `lua/plugins/markdown-keymaps.lua` | Keymaps chính |
| `lua/plugins/markdownlint.lua` | Render config |
| `lazyvim.json` | LazyVim extras config |

---

**🎉 Happy Markdown editing!**

> Nếu gặp vấn đề, check `:checkhealth` và ensure `render-markdown.nvim` được load đúng cách.
