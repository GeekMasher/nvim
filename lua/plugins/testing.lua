-- Testing Code with Neovim

return {
    {
        -- https://github.com/nvim-neotest/neotest
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            -- Rust
            "mrcjkb/rustaceanvim",
            -- Python adapter
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("neotest").setup({
                -- ...,
                adapters = {
                    -- Rust
                    require("rustaceanvim.neotest"),
                    -- Python
                    require("neotest-python"),
                },
            })

            -- Run tests
            vim.keymap.set("n", "<F12>", "<cmd>lua require('neotest').summary.toggle()<cr>")
            vim.keymap.set("n", "<F5>", "<cmd>lua require('neotest').run.run()<cr>")
            vim.keymap.set("n", "<C-F5>", "<cmd>lua require('neotest').run.run(vim.fn.expand(' % '))<cr>")
        end,
    },
}
