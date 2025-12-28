-- General
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
vim.o.wrap = true
vim.g.mapleader = " "


-- Keymaps
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ',u', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d')
vim.keymap.set('n', 'H', ':bp<CR>')
vim.keymap.set('n', 'L', ':bn<CR>')
vim.keymap.set('n', '<leader>t', ':terminal<CR>')
vim.keymap.set('n', '<leader>c', ':nohl<CR>')
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')


-- Plugins
vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
  { src = "https://github.com/webhooked/kanso.nvim" },
  { src = "https://github.com/metalelf0/black-metal-theme-neovim" },
})

-- Plugin initialization
require "nvim-tmux-navigation".setup {}
require "nvim-treesitter.configs".setup {
  ensure_installed = { "c", "go", "vim", "vimdoc", "lua" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- Plugin settings
vim.lsp.enable({ "lua_ls", "gopls" })
vim.cmd("colorscheme kanso-zen")
vim.cmd("hi statusline guibg=NONE")

-- Plugin keymaps
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>g', ":LazyGit<CR>")
vim.keymap.set('n', "<C-h>", ":NvimTmuxNavigateLeft<CR>")
vim.keymap.set('n', "<C-j>", ":NvimTmuxNavigateDown<CR>")
vim.keymap.set('n', "<C-k>", ":NvimTmuxNavigateUp<CR>")
vim.keymap.set('n', "<C-l>", ":NvimTmuxNavigateRight<CR>")

-- Advanced
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end,
})
