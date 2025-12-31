vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.scrolloff = 10
vim.o.cursorline = true
vim.o.wrap = false
vim.g.mapleader = " "
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ',u', ':source $HOME/.config/nvim/init.lua<CR> :update<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', {})
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d')
vim.keymap.set('n', 'H', ':bp<CR>')
vim.keymap.set('n', 'L', ':bn<CR>')
vim.keymap.set('n', '<leader>t', ':terminal<CR>')
vim.keymap.set('n', '<leader>c', ':nohl<CR>')
-- vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+P')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float)

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/alexghergh/nvim-tmux-navigation",
  "https://github.com/brenoprata10/nvim-highlight-colors",
})
vim.lsp.enable({ "lua_ls", "gopls" })
require "nvim-tmux-navigation".setup {}
require "nvim-highlight-colors".setup {}
require "nvim-treesitter.configs".setup { ensure_installed = { "c", "go", "vim", "vimdoc", "lua", "json" }, auto_install = true, highlight = { enable = true, additional_vim_regex_highlighting = false, } }
require "gruvbox".setup({ contrast = "hard", })
vim.cmd("colorscheme gruvbox")
-- vim.cmd("hi statusline guibg=none")
vim.cmd("hi normal guibg=none")
vim.cmd("hi signcolumn guibg=none")
vim.cmd("hi DiagnosticSignWarn guibg=none")
vim.cmd("hi DiagnosticSignErr guibg=none")
vim.cmd("hi DiagnosticSignHint guibg=none")

vim.keymap.set('n', "<C-h>", ":NvimTmuxNavigateLeft<CR>")
vim.keymap.set('n', "<C-j>", ":NvimTmuxNavigateDown<CR>")
vim.keymap.set('n', "<C-k>", ":NvimTmuxNavigateUp<CR>")
vim.keymap.set('n', "<C-l>", ":NvimTmuxNavigateRight<CR>")

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end,
})

