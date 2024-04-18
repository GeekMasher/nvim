return {
	{
		"GeekMasher/DevSecInspect.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- require("devsecinspect").setup({
			--     tools = {
			--         -- SCA
			--         npmaudit = {},
			--         cargoaudit = {},
			--         -- SAST
			--         bandit = {},
			--         semgrep = {},
			--         quibble = {},
			--     },
			-- })
		end,
	},
}
