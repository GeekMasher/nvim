--- Check if a file or directory exists in this path
---@param file any
---@return boolean
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

--- Get the ignore files from .vimignore
---@return table
local function get_ignore_files()
	local files = {
		".git/",
		".vscode/",
		-- General Coding folders
		"bin/",
		-- JS / Node
		"node_modules/",
		-- Python
		".pyc",
		".venv/",
		-- Rust
		"target/",
		"Cargo.lock",
	}
	-- Read from file
	local file = ".vimignore"
	if not file_exists(file) then
		return files
	end
	for line in io.lines(file) do
		if line == nil or line == "" then
			line = ""
		else
			files[#files + 1] = line
		end
	end
	return files
end

return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local sorters = require("telescope.sorters")
			local previewers = require("telescope.previewers")

			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_sorter = sorters.get_fzy_sorter,

					prompt_prefix = "🔍 ",
					hidden = true,
					color_devicons = true,
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,

					-- Customer ignore files func
					file_ignore_patterns = get_ignore_files(),

					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					mappings = {
						i = {
							["<C-x>"] = false,
							["<C-q>"] = actions.close,
						},
					},
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
					file_browser = {
						theme = "dropdown",
						hijack_netrw = true,
					},
				},
			})

			telescope.load_extension("file_browser")
		end,
	},
}
