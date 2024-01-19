return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end
    }
}
