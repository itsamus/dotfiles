vim.api.nvim_set_hl(0, "VimwikiTodoWord", { fg = "#ff5555", bold = true, italic = true }) -- Rood
vim.api.nvim_set_hl(0, "VimwikiDoneWord", { fg = "#50fa7b", bold = true, italic = true }) -- Groen
vim.api.nvim_set_hl(0, "VimwikiPendingWord", { fg = "#ffb86c", bold = true, italic = true }) -- Oranje
vim.api.nvim_set_hl(0, "VimwikiHoldWord", { fg = "#bd93f9", bold = true, italic = true }) -- Paars

-- 2. Koppel de woorden automatisch aan de kleuren zodra een vimwiki-bestand opent
vim.api.nvim_create_autocmd("FileType", {
	pattern = "vimwiki",
	callback = function()
		vim.cmd([[
      syntax match VimwikiTodoWord    "\<TODO\>"
      syntax match VimwikiDoneWord    "\<DONE\>"
      syntax match VimwikiPendingWord "\<PENDING\>"
      syntax match VimwikiHoldWord    "\<HOLD\>"
    ]])
	end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = vim.env.HOME .. "/Wiki/*.md",
	callback = function()
		local filename = vim.fn.expand("%:t:r") -- Haalt de bestandsnaam zonder extensie op als titel
		local date = os.date("%Y-%m-%d") -- Huidige datum
		local template = {
			"---",
			"title: " .. filename,
			"date: " .. date,
			"tags: []",
			"---",
			"",
			"# " .. filename,
			"",
			"",
		}
		vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
	end,
})
vim.g.vimwiki_list = {
	{
		global_ext = 0,
		schemes_web = { "https", "file", ..., "git", "ssh", "fish", "sftp" },
		-- vimwiki_menu = 'Vimwiki',
		use_calendar = 1,
		calendar_action = "vimwiki#diary#calendar_action",

		path = vim.env.HOME .. "/Wiki",
		exclude_files = { "" },
		html_filename_parameterization = 0,
		name = "⌐['°₃°]┘",
		index = "ROOT",
		syntax = "markdown",
		ext = ".md",
		auto_toc = 1,
		toc_header = "Table of Contents",
		toc_header_level = 6,
		toc_link_format = 1,
		auto_tags = 1,
		auto_generate_tags = 1,
		list_margin = 0,
		links_space_char = "_",
		ignore_newline = 1,
		text_ignore_newline = 1,
		-- rx_todo = "\\%$^",
		rx_todo = "\\C\\<\\%(TODO\\|DONE\\|PENDING\\|HOLD\\)\\>",
		hl_cb_checked = 0,
		bullet_types = { "-", "*", "+" },
		cycle_bullets = 1,
		listsyms = " .oX",
		listsym_rejected = "╳",
		listsym_propogate = 1,
		blockquote_markers = ">",
		maxhi = 1,
		-- color_dic = {
		--     "",
		-- },
		nested_syntaxes = {
			python = "python",
			javascript = "javascript",
			rust = "rust",
			go = "go",
			cpp = "cpp",
			c = "c",
			java = "java",
			sh = "sh",
			bash = "bash",
			zsh = "zsh",
			lua = "lua",
			html = "html",
			css = "css",
			xml = "xml",
			json = "json",
			lua = "lua",
			sql = "sql",
			markdown = "markdown",
			vim = "vim",
		},

		diary_rel_path = "Work",
		diary_index = "WORK",
		auto_diary_index = 1,
		diary_header = "",
		diary_sort = "desc",
		diary_caption_level = 6,
		diary_frequency = "daily",
		diary_start_week_day = "monday",
		-- rss_name = "EGG.rss",
		-- rss_max_items = 10,
		-- bese_url = "",

		path_html = vim.env.HOME .. "/Wiki/html",
		-- auto_export = 1 is to automaticly generate a html file for a saved wiki.
		-- auto_export = 1,

		-- Each template could look like: >
		--     <html>
		--     <head>
		--         <link rel="Stylesheet" type="text/css" href="%root_path%style.css" />
		--         <title>%title%</title>
		--         <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		--     </head>
		--     <body>
		--         <div class="content">
		--         %content%
		--         </div>
		--         <p><small>Page created on %date%</small></p>
		--     </body>
		--     </html>
		--
		-- where
		--   `%title%` is replaced by a wiki page name or by a |vimwiki-title|
		--   `%date%` is replaced with the current date or by |vimwiki-date|
		--   `%root_path%` is replaced by a count of ../ for pages buried in subdirs:
		--     if you have wikilink [[dir1/dir2/dir3/my page in a subdir]] then
		--     `%root_path%` is replaced by '../../../'.
		--   `%wiki_path%` Path to current wiki-file.` The file path to the current wiki
		--     file. For example, if you are on page a/b.wiki %wiki-path% contains
		--     "a/b.wiki". Mostly useful if you want to link the to raw wiki page from
		--     the rendered version.
		--
		--   `%content%` is replaced by a wiki file content.
		--
		--
		-- The default template will be applied to all wiki pages unless a page specifies
		-- a template. Consider you have wiki page named 'Maxim.wiki' and you want apply
		-- 'person.html' template to it. Just add: >
		--  %template person
		-- to that page.
		template_path = vim.env.HOME .. "/Templates/Wiki",
		template_default = "default",
		template_ext = ".html",
		--         Description~
		-- The full path to a user-provided script that converts a wiki page to HTML.
		-- Vimwiki calls the provided |vimwiki-option-custom_wiki2html| script from the
		-- command-line, using |:!| invocation.
		--
		-- The following arguments, in this order, are passed to the script:
		--
		-- 1. force : [0/1] overwrite an existing file
		-- 2. syntax : the syntax chosen for this wiki
		-- 3. extension : the file extension for this wiki
		-- 4. output_dir : the full path of the output directory
		-- 5. input_file : the full path of the wiki page
		-- 6. css_file : the full path of the css file for this wiki
		-- 7. template_path : the full path to the wiki's templates
		-- 8. template_default : the default template name
		-- 9. template_ext : the extension of template files
		-- 10. root_path : a count of ../ for pages buried in subdirs
		--     For example, if you have wikilink [[dir1/dir2/dir3/my page in a subdir]]
		--     then this argument is '../../../'.
		-- 11. custom_args : custom arguments that will be passed to the conversion
		--     (can be defined in g:vimwiki_list as 'custom_wiki2html_args' parameter,
		--     see |vimwiki-option-custom_wiki2html_args|)
		--     script.
		--
		-- Options 7-11 are experimental and may change in the future.  If any of these
		-- parameters is empty, a hyphen "-" is passed to the script in its place.
		--
		-- For an example and further instructions, refer to the following script:
		--
		--   $VIMHOME/autoload/vimwiki/customwiki2html.sh
		--
		-- An alternative converter was developed by Jason6Anderson, and can
		-- be located at https://github.com/vimwiki-backup/vimwiki/issues/384
		--
		-- To use the internal wiki2html converter, use an empty string (the default).
		custom_wiki2html = vim.env.HOME .. "/Documents/scripts/vimwiki2html.sh",
		-- custom_wiki2html_args = "--citeproc",

		css_name = "style.css",

		template_date_format = "%Y-%m-%d",

		yaml_metadata_block = {
			{ "^---$", "^\\%(---\\|\\.\\.\\$" },
		},
	},
}
vim.api.nvim_create_autocmd("FileType", {
	pattern = "vimwiki",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "getline(v:lnum)=~/^#\\+?\\s/E1"
	end,
})
