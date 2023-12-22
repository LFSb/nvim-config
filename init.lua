-- General settings
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.clipboard:append("unnamedplus") -- Very important.

-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  { "z0mbix/vim-shfmt", ft = "sh" }, -- It's just shfmt
  { "tpope/vim-surround" }, -- cs<char-to-replace><char-to-replace-it-with>. So cs'" when the cursor is surrounded by ' will surround the word with ".
  { "tpope/vim-commentary" }, -- gcc to comment toggle. gc in visual mode works too.
  { "junegunn/fzf", build = "./install --all" },
  { "junegunn/fzf.vim" },
  { "kaplanz/retrail.nvim", opts = {}}, -- trim whitespace
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Fancier syntax highlighter
  { "sheerun/vim-polyglot" }, -- Syntax highlighting for a bunch of languages
  { "williamboman/mason.nvim", lazy = false}, -- lsp/dap/formatter/linter package manager
  { "williamboman/mason-lspconfig.nvim", lazy = false}, -- glue between mason.nvim and nvim-lspconfig
  { "neovim/nvim-lspconfig", lazy = false }, -- nvim's own lspconfig
  { "hrsh7th/nvim-cmp"}, -- Autocomplete
  { "hrsh7th/cmp-nvim-lsp"},
  { "hrsh7th/cmp-vsnip"}, -- Snippet engine for autocomplete
  { "hrsh7th/vim-vsnip"}, -- Snippet engine for autocomplete
})


-- nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['terraformls'].setup {
  capabilities = capabilities
}

require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities
}

require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}

require('lspconfig')['elixirls'].setup {
  capabilities = capabilities,
  cmd = { "/Users/leebeenen/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" };
}

require('lspconfig')['azure_pipelines_ls'].setup {
  capabilities = capabilities
}

require('lspconfig')['yamlls'].setup {
  capabilities = capabilities
}
-- lspconfig
vim.api.nvim_set_keymap('n', 'gl', ':lua vim.diagnostic.open_float()<CR>', {}) -- Display whatever error/warning the lsp has deemed appropriate.

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Shfmt
vim.g.shfmt_fmt_on_save = 1
vim.g.shfmt_extra_args = '-i 2'

-- Set colorscheme
vim.cmd [[colorscheme nightfly]]
