return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "AndreM222/copilot-lualine",
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    },
                },
                lualine_c = { "filename" },
                lualine_x = { "copilot", "encoding", "fileformat", "filetype" }, -- I added copilot here
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}
