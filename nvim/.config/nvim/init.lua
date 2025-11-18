-- Set mapleader
vim.g.mapleader = " "

-- Set vim options
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autochdir = true
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.signcolumn = "yes:1"

vim.opt.termguicolors = true

-- Set some global keymaps
vim.keymap.set("i", "<leader>jk", "<ESC>")
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y"]])
vim.keymap.set("n", "<leader Y", [["+Y"]])

local opts = { noremap = true, silent = true }

vim.keymap.set("", "<up>", "<nop>", opts)
vim.keymap.set("", "<down>", "<nop>", opts)
vim.keymap.set("", "<left>", "<nop>", opts)
vim.keymap.set("", "<right>", "<nop>", opts)
vim.keymap.set("", "<C-up>", "<nop>", opts)
vim.keymap.set("", "<C-down>", "<nop>", opts)
vim.keymap.set("", "<C-left>", "<nop>", opts)
vim.keymap.set("", "<C-right>", "<nop>", opts)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>")

-- Use autocommand to highlight yanking
vim.cmd [[augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=500})
augroup END]]

vim.o.clipboard = 'unnamedplus'

-- Special autocommand for when using wsl on windows
if vim.fn.has('wsl') == 1 then
	vim.api.nvim_create_autocmd('TextYankPost', {
		group = vim.api.nvim_create_augroup('Yank', { clear = true }),
		callback = function()
			vim.fn.system('clip.exe', vim.fn.getreg('"'))
		end,
	})
end

vim.g.netrw_keepdir = 0

-- Install packages using vim.pack

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.extra" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },

	-- LSP Plugins
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },

	{ src = "https://github.com/folke/lazydev.nvim" },
})

-- Set colorscheme
vim.cmd("colorscheme rose-pine")

-- Setup Oil
require "oil".setup()
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")

-- Setup mini.pick
require "mini.pick".setup({
	mappings = {
		choose_marked = "<C-q>"
	}
})

require "mini.extra".setup()

vim.keymap.set("n", "<leader>e", ":Pick diagnostic scope='current'<CR>", {})
vim.keymap.set("n", "<leader>pf", ":Pick files<CR>", {})
vim.keymap.set("n", "<leader>en", function()
	MiniPick.builtin.files(
		nil,
		{
			src = {
				cwd = vim.fn.stdpath("config")
			}
		})
end, {})

vim.keymap.set("n", "<leader>gf", ":Pick files tool='git'<CR>", {})

vim.keymap.set("n", "<leader>fb", function()
	MiniExtra.pickers.buf_lines(
		nil,
		{
			scope = "current"
		})
end, {})

vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", {})
vim.keymap.set("n", "<leader>ps", ":Pick grep_live<CR>", {})

-- Setup lualine
require "lualine".setup()

-- Setup lsp
require "mason".setup()
require "mason-lspconfig".setup()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		local mini = require("mini.extra")

		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>gr', function()
			mini.pickers.lsp({ scope = "references" }, nil)
		end, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)

		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			buffer = 0,
			callback = function()
				vim.lsp.buf.format({ async = true })
			end,
		})
	end,
})

-- Setup lazydev to remove warnings in lua vim config files
require "lazydev".setup({
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
})
