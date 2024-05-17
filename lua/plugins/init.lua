return {
    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
    },
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({})
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
                    -- ...,
                    require("rustaceanvim.neotest"),
                },
            })
        end,
    },
    -- Trouble
    {
        -- https://github.com/folke/trouble.nvim
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = true,
                height = 15,
                mode = "document_diagnostics",
                -- auto_open = true,
                auto_close = true,
                action_keys = {
                    close = "q",
                    toggle_mode = "m",
                },
            })
        end,
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
