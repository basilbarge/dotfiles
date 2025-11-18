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
