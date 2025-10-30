return {
	"nvim-mini/mini.pick",
	dependencies = {
		"nvim-mini/mini.extra",
	},
	version = false,
	config = function()
		require("mini.pick").setup()
		require("mini.extra").setup()

		vim.keymap.set('n', '<leader>e', ":Pick diagnostic scope='current'<CR>", {})
		vim.keymap.set('n', '<leader>pf', ":Pick files<CR>", {})
		vim.keymap.set('n', '<leader>en', function()
			MiniPick.builtin.files(
				nil,
				{
					source = {
						cwd = vim.fn.stdpath("config")
					}
				}
			)
		end)
		vim.keymap.set('n', '<leader>gf', ":Pick files tool='git'<CR>", {})
		vim.keymap.set('n', '<leader>fb', function()
			MiniPick.builtin.grep_live(
				{
					globs = { vim.fn.expand("%:t") }
				},
				nil
			)
		end)
		vim.keymap.set('n', '<leader>fh', ":Pick help<CR>", {})
		vim.keymap.set('n', '<leader>ps', ":Pick grep_live<CR>", {})
	end
}
