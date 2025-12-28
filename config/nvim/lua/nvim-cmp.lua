local lspkind = require('lspkind')
local cmp     = require('cmp')
local luasnip = require('luasnip')

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '…',
      show_labelDetails = true,
    }),
  },
  mapping = {
    ['<Up>']      = cmp.mapping.select_prev_item(),
    ['<Down>']    = cmp.mapping.select_next_item(),
    ['<C-p>']     = cmp.mapping.select_prev_item(),
    ['<C-n>']     = cmp.mapping.select_next_item(),
    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ select = false }),
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- git-commit
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
    { name = 'buffer' },
  }),
})
require('cmp_git').setup()

-- search
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<C-w>a', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<C-w>r', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<C-w>l', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.lsp.enable({
  'astro',
  'bashls',
  'clangd',
  'crystalline',
  'eslint',
  'gleam',
  'gopls',
  'java_language_server',
  'lua_ls',
  'nil_ls',
  'pyright',
  'rust_analyzer',
  'tailwindcss',
  'terraform_lsp',
  'tinymist',
  'ts_ls',
  'zls',
}, true)

vim.lsp.config('lua_ls', {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = { Lua = {} },
})

vim.lsp.config('eslint', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'jsx', 'html' },
})

vim.lsp.config('java_language_server', {
  cmd = { 'java-language-server' },
})

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = { command = { 'alejandra', '--quiet' } },
      nix = {
        maxMemoryMB = 8192,
        flake = { autoEvalInputs = true },
      },
    },
  },
})

vim.lsp.config('tinymist', {
  settings = { exportPdf = 'onSave' },
  filetypes = { 'typst', 'typ' },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      files = {
        exclude = { '.direnv', 'target' }
      }
    }
  }
})
