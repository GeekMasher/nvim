-- Testing Code with Neovim

return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("neotest").setup({
                -- ...,
                adapters = {
                    -- Rust
                    require("rustaceanvim.neotest"),
                },
            })

            -- Run tests
            vim.keymap.set("n", "<F5>", "<cmd>lua require('neotest').run.run()<cr>")
            vim.keymap.set("n", "<C-F5>", "<cmd>lua require('neotest').run.run(vim.fn.expand(' % '))<cr>")
        end,
    },
}
