vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "100"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.undofile = true
vim.opt.undodir = "/tmp"
vim.opt.termguicolors = true
vim.opt.showtabline = 1
vim.opt.laststatus = 3

vim.g.completeopt = { "menu", "menuon", "noselect" }
vim.g.mapleader = " "
vim.g.background = "dark"

-- shared options to pass into each mapping
local opts = { silent = true }

-- Visual: keep selection after shifting
vim.keymap.set('v', '<', '<gv', vim.tbl_extend('force', opts, { desc = 'Visual: indent left and reselect' }))
vim.keymap.set('v', '>', '>gv', vim.tbl_extend('force', opts, { desc = 'Visual: indent right and reselect' }))

-- Search: keep match centered
vim.keymap.set('n', 'n', 'nzz', vim.tbl_extend('force', opts, { desc = 'Search: next and center' }))
vim.keymap.set('n', 'N', 'Nzz', vim.tbl_extend('force', opts, { desc = 'Search: previous and center' }))

-- Tabs: new / split / close / only
vim.keymap.set('n', '<leader><Tab>n', ':tabnew<CR>', vim.tbl_extend('force', opts, { desc = 'Tab: new' }))
vim.keymap.set('n', '<leader><Tab>s', ':tab split<CR>', vim.tbl_extend('force', opts, { desc = 'Tab: split' }))
vim.keymap.set('n', '<leader><Tab>d', ':tabclose<CR>', vim.tbl_extend('force', opts, { desc = 'Tab: close' }))
vim.keymap.set('n', '<leader><Tab>o', ':tabonly<CR>', vim.tbl_extend('force', opts, { desc = 'Tab: only' }))

-- Tabs: prev/next
vim.keymap.set('n', 'H', 'gT', vim.tbl_extend('force', opts, { desc = 'Tab: previous' }))
vim.keymap.set('n', 'L', 'gt', vim.tbl_extend('force', opts, { desc = 'Tab: next' }))

-- Tabs: jump to 1..9
for i = 1, 9 do
  vim.keymap.set(
    'n',
    '<leader><Tab>' .. i,
    ':tabnext ' .. i .. '<CR>',
    vim.tbl_extend('force', opts, { desc = 'Tab: go to ' .. i })
  )
end

-- Splits
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', vim.tbl_extend("force", opts, { desc = "Window: split horizontally" }))
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', vim.tbl_extend("force", opts, { desc = "Window: split vertically" }))

-- Navigation (focus)
vim.keymap.set('n', '<leader>wh', '<C-w>h', vim.tbl_extend("force", opts, { desc = "Window: go left" }))
vim.keymap.set('n', '<leader>wj', '<C-w>j', vim.tbl_extend("force", opts, { desc = "Window: go down" }))
vim.keymap.set('n', '<leader>wk', '<C-w>k', vim.tbl_extend("force", opts, { desc = "Window: go up" }))
vim.keymap.set('n', '<leader>wl', '<C-w>l', vim.tbl_extend("force", opts, { desc = "Window: go right" }))

-- Move window to edge
vim.keymap.set('n', '<leader>wH', '<C-w>H', vim.tbl_extend("force", opts, { desc = "Window: move to left edge" }))
vim.keymap.set('n', '<leader>wJ', '<C-w>J', vim.tbl_extend("force", opts, { desc = "Window: move to bottom edge" }))
vim.keymap.set('n', '<leader>wK', '<C-w>K', vim.tbl_extend("force", opts, { desc = "Window: move to top edge" }))
vim.keymap.set('n', '<leader>wL', '<C-w>L', vim.tbl_extend("force", opts, { desc = "Window: move to right edge" }))

-- Equalize / rotate / close / only
vim.keymap.set('n', '<leader>w=', '<C-w>+', vim.tbl_extend("force", opts, { desc = "Window: equalize sizes" }))
vim.keymap.set('n', '<leader>wr', '<cmd>wincmd r<CR>', vim.tbl_extend("force", opts, { desc = "Window: rotate" }))
vim.keymap.set('n', '<leader>wd', '<cmd>close<CR>', vim.tbl_extend("force", opts, { desc = "Window: close" }))
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', vim.tbl_extend("force", opts, { desc = "Window: only" }))
vim.keymap.set('n', '<leader>wt', '<cmd>tab split<CR>', vim.tbl_extend("force", opts, { desc = "Window: open in new tab" }))

-- Resizing: vertical
vim.keymap.set('n', '<leader>w<', '<cmd>vertical resize -5<CR>', vim.tbl_extend("force", opts, { desc = "Window: shrink vertical" }))
vim.keymap.set('n', '<leader>w>', '<cmd>vertical resize +5<CR>', vim.tbl_extend("force", opts, { desc = "Window: widen vertical" }))
-- Resizing: height

vim.keymap.set('n', '<leader>w-', '<cmd>resize -2<CR>', vim.tbl_extend("force", opts, { desc = "Window: decrease height" }))
vim.keymap.set('n', '<leader>w=', '<cmd>resize +2<CR>', vim.tbl_extend("force", opts, { desc = "Window: increase height" }))

-- Maximize (simple fallback: only). Replace with plugin toggle if you prefer a real toggle.
vim.keymap.set('n', '<leader>wm', '<cmd>only<CR>', vim.tbl_extend("force", opts, { desc = "Window: maximize (only)" }))

-- trim whitespace at the end of a line
vim.cmd [[autocmd BufWritePre * :%s/\s+$//e]]
