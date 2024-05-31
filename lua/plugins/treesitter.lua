return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-context",
        },
        opts = {
            ensure_installed = {
                "rust",
                "go",
                "python",
                "bash",
                -- Neovim
                "lua",
                "luadoc",
                -- web
                "javascript",
                "typescript",
                "html",
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
            incremental_selection = {
                enable = true,
            },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            text_objects = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
