return {
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        event = "VimEnter",
        config = function()
            require("gitsigns").setup()
        end,
    },
    -- Which Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    --
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "folke/neodev.nvim",
        opts = {},
    },
    -- todo comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = { signs = false },
    },
    -- Trouble
    {
        -- https://github.com/folke/trouble.nvim
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            height = 15,
            mode = "document_diagnostics",
            auto_close = true,
        },
        keys = {
            {
                "<F10>",
                "<cmd>Trouble diagnostics toggle<cr>",
            },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                -- <C-_> == <CTRL> /
                toggler = { line = "<C-_>" },
                opleader = { line = "<C-_>" },
            })
        end,
    },
}
