vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<leader>jk", "<ESC>")

vim.keymap.set("", "<up>", "<noop>")
vim.keymap.set("", "<down>", "<noop>")
vim.keymap.set("", "<left>", "<noop>")
vim.keymap.set("", "<right>", "<noop>")

local set = vim.opt

vim.cmd("set autochdir")
--set.autochdir = true
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.number = true
set.relativenumber = true
