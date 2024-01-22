return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.install").update({ with_sync = true })
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"go",
					"python",
					"javascript",
					"typescript",
					"rust",
					"lua",
					-- misc
					"regex",
					"ql",
					-- config files
					"toml",
					"yaml",
					"json",
					"markdown",
					"dockerfile",
				},
			})
		end,
	},
}
