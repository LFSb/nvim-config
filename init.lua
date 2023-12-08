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
  { "z0mbix/vim-shfmt", ft = "sh" },
  { "tpope/vim-surround" }, -- cs<char-to-replace><char-to-replace-it-with>. So cs'" when the cursor is surrounded by ' will surround the word with ".
  { "tpope/vim-commentary" }, -- gcc to comment toggle. gc in visual mode works too.
  { "junegunn/fzf", build = "./install --all" },
  { "junegunn/fzf.vim" },
  { "kaplanz/retrail.nvim", opts = {}},
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "sheerun/vim-polyglot" },
  { "williamboman/mason.nvim", lazy = false},
  { "williamboman/mason-lspconfig.nvim", lazy = false},
  { "neovim/nvim-lspconfig", lazy = false },
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-lspconfig
require("lspconfig")["terraformls"].setup({})

-- Shfmt
vim.g.shfmt_fmt_on_save = 1

-- Set colorscheme
vim.cmd [[colorscheme nightfly]]
