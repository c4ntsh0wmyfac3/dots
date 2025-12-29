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
vim.keymap.set('n', ',u', ':source $HOME/.config/nvim/init.lua<CR> :update<CR>')
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
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+P')


-- Plugins
vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
  { src = "https://github.com/webhooked/kanso.nvim" },
  { src = "https://github.com/metalelf0/black-metal-theme-neovim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

-- Plugin initialization
require "nvim-tmux-navigation".setup {}
require "nvim-treesitter.configs".setup {
  ensure_installed = { "c", "go", "vim", "vimdoc", "lua", "json" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- Plugin settings
vim.lsp.enable({ "lua_ls", "gopls" })
vim.cmd("colorscheme kanso-zen")
vim.cmd("hi Normal guibg=#10101a")
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

-- Autocomplete
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Навигация по меню
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
