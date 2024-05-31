return {
    -- Rust
    -- https://github.com/simrat39/rust-tools.nvim
    -- https://rust-analyzer.github.io/manual.html#nvim-lsp
    -- https://sharksforarms.dev/posts/neovim-rust/
    {
        "mrcjkb/rustaceanvim",
        event = "VeryLazy",
    },
    {
        "saecki/crates.nvim",
        event = "VeryLazy",
        config = function()
            require("crates").setup({
                smart_insert = true,
                autoupdate = false,
                text = {
                    loading = " Loading...",
                    version = " %s",
                    prerelease = " %s",
                    yanked = " %s",
                    nomatch = " No match",
                    upgrade = " %s",
                    error = " Error fetching crate",
                },
            })
        end,
    },
}
