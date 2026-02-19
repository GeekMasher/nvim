--- AI Selector
local M = {}

M.current_ai = nil

local function unload_copilot()
  vim.cmd("silent! Copilot disable")
  pcall(function()
    require("copilot").setup({ panel = { enabled = false }, suggestion = { enabled = false } })
  end)
  vim.cmd("silent! Lazy unload copilot.lua")
  vim.cmd("silent! Lazy unload CopilotChat.nvim")
  vim.cmd("silent! Lazy unload copilot-cmp")
end

local function unload_claudecode()
  vim.cmd("silent! ClaudeCodeClose")
  vim.cmd("silent! Lazy unload claudecode.nvim")
end

function M.select_ai()
  vim.ui.select({ "copilot", "claudecode" }, {
    prompt = "Select AI Assistant:",
    format_item = function(item)
      if item == "copilot" then
        return "  GitHub Copilot"
      elseif item == "claudecode" then
        return "  Claude Code"
      end
    end,
  }, function(choice)
    if not choice then
      return
    end

    if M.current_ai == choice then
      vim.notify("Already using " .. choice, vim.log.levels.INFO)
      return
    end

    if M.current_ai == "copilot" then
      unload_copilot()
    elseif M.current_ai == "claudecode" then
      unload_claudecode()
    end

    M.current_ai = choice
    vim.g.selected_ai = choice

    if choice == "copilot" then
      vim.cmd("Lazy load copilot.lua copilot-cmp CopilotChat.nvim")
      vim.notify("Loaded GitHub Copilot", vim.log.levels.INFO)
    elseif choice == "claudecode" then
      vim.cmd("Lazy load claudecode.nvim")
      vim.notify("Loaded Claude Code", vim.log.levels.INFO)
    end
  end)
end

vim.api.nvim_create_user_command("SelectAI", M.select_ai, { desc = "Select AI Assistant" })

vim.keymap.set("n", "<leader>as", M.select_ai, { desc = "Select AI Assistant" })

return M
