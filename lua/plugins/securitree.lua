return {
    {
        -- "GeekMasher/securitree.nvim",
        dir = "~/development/security/securitree.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("securitree").setup({
                autocmd = false,
                -- autopanel = true,
                features = {
                    assertions = true
                },
                paths = {
                    "/home/geekmasher/development/security/securitree.nvim/queries"
                }
            })
        end
    }
}
