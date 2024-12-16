vim.g.mapleader = " "

vim.keymap.set("i", "<leader>jk", "<ESC>")
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y"]])
vim.keymap.set("n", "<leader Y", [["+Y"]])

vim.keymap.set("", "<up>", "<noop>")
vim.keymap.set("", "<down>", "<noop>")
vim.keymap.set("", "<left>", "<noop>")
vim.keymap.set("", "<right>", "<noop>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

local set = vim.opt

local opts = { noremap = true, silent = true }

vim.cmd("set autochdir")
--set.autochdir = true
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.number = true
set.relativenumber = true

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
