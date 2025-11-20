vim.g.mapleader = " "

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

local set = vim.opt

vim.cmd("set autochdir")
--set.autochdir = true
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.number = true
set.relativenumber = true
set.signcolumn = "yes:1"

set.termguicolors = true

vim.cmd [[augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=500})
augroup END]]

vim.o.clipboard = 'unnamedplus'

if vim.fn.has('wsl') == 1 then
	vim.api.nvim_create_autocmd('TextYankPost', {
		group = vim.api.nvim_create_augroup('Yank', { clear = true }),
		callback = function()
			vim.fn.system('clip.exe', vim.fn.getreg('"'))
		end,
	})
end

vim.g.netrw_keepdir = 0
