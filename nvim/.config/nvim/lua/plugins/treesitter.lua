return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter'.setup {
				ensure_installed = { "go", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				--indent = { enable = true },
			}
		end
	},
	'nvim-treesitter/nvim-treesitter-context',
}
