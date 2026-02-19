return {
  { import = "plugins.ai.copilot" },
  { import = "plugins.ai.claudecode" },
  {
    name = "ai-selector",
    dir = vim.fn.stdpath("config"),
    config = function()
      require("plugins.ai.selector")
    end,
  },
}
