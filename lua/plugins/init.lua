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
    -- https://github.com/nvim-mini/mini.comment
    -- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/plugins/extras/coding/mini-comment.lua
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        ignore_blank_line = true,
      },
      mappings = {
        comment = "<leader>c",
        comment_visual = "<leader>c",
      },
    },
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
}
