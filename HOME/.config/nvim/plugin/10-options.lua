local set = vim.opt

-- ───────────────╮
-- neovim options │
-- ───────────────┴─────────────────────────────────────────────────────────────
vim.g.mapleader = " " -- set global mapleader
vim.g.localmapleader = " " -- set global localmapleader

-- Table of Contents

-- 1. UI-&-Display

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. UI-&-Display
set.cursorline = true --   highlight the screen line of the cursor
set.cursorlineopt = "both" --   settings for 'cursorline'
set.fillchars = { --   characters to use for displaying special items
	stl = " ",
	stlnc = " ",
	wbr = " ",
	horiz = "═",
	horizup = "╩",
	horizdown = "╦",
	vert = "║",
	vertleft = "╣",
	vertright = "╠",
	verthoriz = "╬",
	-- fold
	-- foldclose
	-- foldsep
	-- diff
	-- msgsep
	eob = " ",
	-- lastline
	-- trunc
	-- truncrl
}
set.guicursor = { -- 	GUI: settings for cursor shape and blinking
	"n:block",
	"v:block",
	"ve:block",
	"o:hor50",
	"i:ver50",
	"r:hor50",
	"c:block",
	"ci:hor50",
	"cr:hor50",
	"sm:hor50",
	"t:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}
set.icon = true --  let Vim set the text of the window icon
set.iconstring = "Neovim - %t" --  string to use for the Vim icon text
set.list = true --  show <Tab> and <EOL>
set.listchars = {
	eol = "$",
	tab = " ‧",
	-- space = "",
	multispace = " ‧",
	leadtab = "🯟──",
	leadmultispace = "🯟──",
}
set.number = true -- 	print the line number in front of each line
-- set.relativenumber -- 	show relative line number in front of each line
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		local mode = vim.v.event.new_mode
		-- Check of we in een visual mode zijn (v, V, of Ctrl-V)
		if mode:match("^[vV\22]") then
			vim.wo.relativenumber = true
		else
			vim.wo.relativenumber = false
		end
	end,
})
set.termguicolors = true -- 	enable 24-bit RGB color in the TUI

-- Tabs & Indentation
set.expandtab = true -- 	use spaces when <Tab> is inserted
set.shiftwidth = 4 -- 	number of spaces to use for (auto)indent step
set.smarttab = true -- 	<Tab> in leading whitespace indents by 'shiftwidth'
set.softtabstop = 4 -- 	number of columns between two soft tab stops
set.tabstop = 4 -- 	number of columns between two tab stops

-- Wrapping & Formatting
set.breakat = " ^I@*-+;:,./?" -- characters that may cause a line break
set.breakindent = true -- wrapped line repeats indent
-- set.breakindentopt -- 	settings for 'breakindent'
-- set.comments -- 	patterns that can start a comment line
-- set.commentstring -- 	template for comments; used for fold marker
set.formatlistpat = [[^\s*([-*+]|\d\+[.)]|\d\+[:])\s+]] -- 	pattern used to recognize a list header
set.formatoptions = "jcrqln" -- 	how automatic formatting is to be done
set.linebreak = true -- 	wrap long lines at a blank
set.showbreak = "  ╰─ " -- 	string to use at the start of wrapped lines

-- Completion & Spelling
set.autocomplete = true -- enable automatic completion in insert mode
set.complete = { -- specify how Insert mode completion works
	-- ".",         -- scan the current buffer ('wrapscan' is ignored)
	"i^10", -- scan current and included files
	"d^2", -- scan current and included files for defined name or macro
	-- |i_CTRL-X_CTRL-D|
	"]^2", -- tag completion
	-- "F{func}",   -- call the function {func}.  Multiple "F" flags may be
	-- specified.  Refer to |complete-functions| for details on how
	-- the function is invoked and what it should return.  The value
	-- can be the name of a function or a |Funcref|.  For |Funcref|
	-- values, spaces must be escaped with a backslash ('\'), and
	-- commas with double backslashes ('\\') (see |option-backslash|).
	-- Unlike other sources, functions can provide completions
	-- starting from a non-keyword character before the cursor, and
	-- their start position for replacing text may differ from other
	-- sources.  If the Dict returned by the {func} includes
	-- `{"refresh": "always"}`, the function will be invoked again
	-- whenever the leading text changes.
	-- If generating matches is potentially slow, call
	-- |complete_check()| periodically to keep Vim responsive.  This
	-- is especially important for |ins-autocompletion|.
	-- "F",         --          equivalent to using "F{func}", where the function is taken
	--          from the 'completefunc' option.
	-- "o",         --        equivalent to using "F{func}", where the function is taken
	--        from the 'omnifunc' option.
	"k^3", -- scan the files given with the 'dictionary' option
	-- "w",         -- scan buffers from other windows
	-- "b",         -- scan other loaded buffers that are in the buffer list
	-- "u",         -- scan the unloaded buffers that are in the buffer list
	-- "U",         -- scan the buffers that are not in the buffer list
	-- "kspell",    -- use the currently active spell checking |spell|
	-- "k{dict}",   -- scan the file {dict}.  Several "k" flags can be given,
	-- patterns are valid too.  For example: >vim
	-- 	set cpt=k/usr/dict/*,k~/spanish
	-- "s",         -- scan the files given with the 'thesaurus' option
	-- "s{tsr}",    -- scan the file {tsr}.  Several "s" flags can be given, patterns
	-- are valid too.
	-- "f",         -- scan the buffer names (as opposed to buffer contents)
}
-- set.completefunc -- 	function to be used for Insert mode completion
set.completeopt = { -- 	options for Insert mode completion
	"fuzzy",
	"menuone",
	"popup",
	"preview",
}
set.dictionary = "/usr/share/dict/american-english-insane" -- 	list of file names used for keyword completion
set.omnifunc = "v:lua.vim.lsp.omnifunc" -- 	function for filetype-specific completion
set.spell = true -- 	enable spell checking
set.spellcapcheck = [[[.?!]\_[\])'"	 ]\+]] -- 	pattern to locate end of a sentence
-- set.spellfile  -- 	files where |zg| and |zw| store words
set.spelllang = "en" -- 	language(s) to do spell checking for

-- Windows & Layout
set.cmdheight = 0 -- 	number of lines to use for the command-line
-- set.previewheight -- 	height of the preview window
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     callback = function()
--         -- Controleer of we in een preview-venster zijn
--         if vim.bo.buftype == "preview" then
--             local line_count = vim.api.nvim_buf_line_count(0)
--             -- Stel een dynamische hoogte in: minstens 3 regels, maximaal 20 regels
--             local target_height = math.min(math.max(line_count, 3), 20)
--             vim.api.nvim_win_set_height(0, target_height)
--         end
--     end,
-- })
-- set.previewwindow -- 	identifies the preview window
-- set.pumheight -- 	maximum number of items to show in the popup menu
-- set.pumwidth -- 	minimum width of the popup menu
set.splitbelow = true -- 	new window from split is below the current one
set.splitkeep = "screen" -- 	determines scroll behavior for split windows
set.splitright = true -- 	new window is put right of the current one
-- set.statuscolumn  -- 	custom format for the status column
-- set.statusline -- 	custom format for the status line

-- Search & Patterns
set.ignorecase = true -- 	ignore case in search patterns
set.smartcase = true -- 	no ignore case when pattern has uppercase

-- Files & Paths
-- set.cdpath -- 	list of directories searched with ":cd"
set.grepprg = "rg --vimgrep --smart-case --hidden" -- 	program to use for ":grep"
-- set.path -- 	list of directories searched with "gf" et.al.

-- Code Navigation
-- set.tagbsearch -- 	use binary searching in tags files
-- set.tagcase -- 	how to handle case when searching in tags files
-- set.tagfunc -- 	function to get list of tag matches
-- set.taglength -- 	number of significant characters for a tag
-- set.tagrelative -- 	file names in tag file are relative
-- set.tags -- 	list of file names used by the tag command
-- set.tagstack -- 	push tags onto the tag stack

-- Behavior
set.matchpairs = {
	"(:)",
	"[:]",
	"{:}",
	"<:>",
	'":"',
	"':'",
} -- 	pairs of characters that "%" can match
set.mouse = "a" -- 	enable the use of mouse clicks
set.showmatch = true -- 	briefly jump to matching bracket if insert one
set.virtualedit = "block" -- 	when to use virtual editing
-- set.whichwrap

-- CLI & History
set.clipboard = "unnamedplus" -- 	use the clipboard as the unnamed register
set.helplang = "nl,en" -- 	preferred help languages
set.history = 30 -- 	number of command-lines that are remembered
set.shada = "'100,<50,s10,:30,/100,@100,h" -- 	use |shada| file upon startup and exiting
set.undofile = true -- 	save undo information in a file
-- set.undodir -- 	where to store undo files
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end
set.undolevels = 100 -- 	maximum number of changes that can be undone

-- set.wildchar = "<C-n>,<C-p>,<TAB>" -- 	command-line character for wildcard expansion
set.wildcharm = "<C-n>,<C-p>,<TAB>" -- 	like 'wildchar' but also works when mapped
set.wildignore = { -- 	files matching these patterns are not completed
	"*.o",
	"*.obj",
	"*.exe",
	"*.dll",
	"*.pyc",
	".git",
	".hg",
	".svn",
	"*.aux",
	"*.out",
	"*.toc",
	"*.jpg",
	"*.png",
	"*.gif",
	"*.zip",
	"*.tar.gz",
	"**/node_modules/*",
	"**/bower_components/*",
	"**/node_modules/*",
	"**/bower_components/*",
}
set.wildignorecase = true -- 	ignore case when completing file names
set.wildoptions = "fuzzy" -- 	specifies how command line completion is done

-- Diff
-- set.diff -- 	use diff mode for the current window
-- set.diffanchors -- 	list of {address} to force anchoring of a diff
-- set.diffexpr -- 	expression used to obtain a diff file
-- set.diffopt -- 	options for using diff mode

-- Stel een globale quickfix-tekstfunctie in
-- vim.o.quickfixtextfunc = "v:lua.custom_quickfix_display"
--
-- function _G.custom_quickfix_display(info)
--     local items = vim.fn.getqflist({ id = info.id, items = 0 }).items
--     local ret = {}
--
--     for i = info.start_idx, info.end_idx do
--         local item = items[i]
--         -- Haal de bestandsnaam op of geef een placeholder als er geen bestand is
--         local filename = ""
--         if item.bufnr > 0 then
--             filename = vim.fn.bufname(item.bufnr)
--             if filename == "" then
--                 filename = "[Geen bestand]"
--             else
--                 -- Kort het pad in tot alleen de bestandsnaam (of relatief pad)
--                 filename = vim.fn.fnamemodify(filename, ":.")
--             end
--         end
--
--         -- Bepaal de opmaak van de regel
--         local lnum = item.lnum > 0 and item.lnum or 0
--         local col = item.col > 0 and item.col or 0
--         local text = item.text
--
--         -- Bouw de aangepaste string op
--         local entry = string.format("%s:%d:%d: %s", filename, lnum, col, text)
--         table.insert(ret, entry)
--     end
--
--     return ret
-- end

vim.diagnostic.config({
	-- 1. Tekst direct achter/naast de code (Virtual Text)
	virtual_text = {
		enabled = true,
		-- severity = nil,             -- Bijv. vim.diagnostic.severity.ERROR voor alleen fouten
		-- source = "if_many",         -- "always", "if_many", of false
		-- format = nil,               -- Functie: function(diagnostic) return string end
		-- prefix = "■",               -- Prefix string, bijv. '●', '■', of een functie
		-- spacing = 4,                -- Aantal spaties tussen code en de tekst
		-- suffix = "",                -- Suffix na de tekst
	},

	-- -- 2. Drijvend venster / Pop-up bij hover (Float options)
	-- -- (Deze instellingen gelden als je `vim.diagnostic.open_float()` aanroept)
	-- float = {
	--   enabled = true,
	--   focused = false,
	--   focusable = true,
	--   close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	--   border = "rounded",         -- "none", "single", "double", "rounded", "solid", "shadow"
	--   source = "if_many",         -- "always", "if_many", of false
	--   prefix = nil,
	--   suffix = nil,
	--   format = nil,               -- Functie om de tekst per regel aan te passen
	--   header = "Diagnostics:",    -- String of tabel: { "Header", "HighlightGroup" }
	--   scope = "line",             -- "line", "cursor", of "buffer"
	--   severity_sort = true,       -- Sorteer op ernst (ERROR > WARN > INFO > HINT)
	-- },
	--
	-- -- 3. Tekens in de 'gutter' / kantlijn (Signs)
	-- signs = {
	--   active = true,              -- Kan ook een tabel zijn om tekens per niveau in te stellen
	--   severity = nil,
	--   priority = 10,              -- Prioriteit van de sign
	--   text = {
	--     [vim.diagnostic.severity.ERROR] = " ",
	--     [vim.diagnostic.severity.WARN]  = " ",
	--     [vim.diagnostic.severity.INFO]  = " ",
	--     [vim.diagnostic.severity.HINT]  = " ",
	--   },
	--   linehl = {                  -- Highlight-groepen voor de hele regel
	--     -- [vim.diagnostic.severity.ERROR] = "ErrorLine",
	--   },
	--   numhl = {                   -- Highlight-groepen voor het regelnummer
	--     -- [vim.diagnostic.severity.ERROR] = "ErrorNum",
	--   },
	-- },
	--
	-- -- 4. Onderstrepen van code met fouten
	-- underline = {
	--   severity = nil,             -- Filter op ernst als je niet alles wilt onderstrepen
	-- },
	--
	-- -- 5. Status in de Quickfix- / Location-list
	-- severity_sort = true,         -- Sorteer diagnostics op ernst binnen de lijsten
	--
	-- -- 6. Update-frequentie tijdens typen
	-- update_in_insert = true,     -- `true` werk diagnostics bij tijdens het typen in Insert-mode
	--
	-- -- 7. Diagnostics globaal in-/uitschakelen
	-- virtual_lines = true,        -- Toon diagnostics op een nieuwe virtuele regel onder de code (Neovim 0.10+)
})

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
-- 0. Not Yet Inplemented

-- set.browsedir -- 	which directory to start browsing in
-- ─────────────────────────────────────────────────────────────────────────────────────────────────

-- set.background -- 	"dark" or "light", used for highlight colors
-- set.backspace -- 	how backspace works at start of line
-- set.backup -- 	keep backup file after overwriting a file
-- set.backupcopy -- 	make backup as a copy, don't rename the file
-- set.backupdir -- 	list of directories for the backup file
-- set.backupext -- 	extension used for the backup file
-- set.backupskip -- 	no backup for files that match these patterns
-- set.belloff -- 	do not ring the bell for these reasons
-- set.binary -- 	read/write/edit file in binary mode
-- set.bomb -- 	prepend a Byte Order Mark to the file
-- set.bufhidden -- 	what to do when buffer is no longer in window
-- set.buflisted -- 	whether the buffer shows up in the buffer list
-- set.buftype -- 	special type of buffer
-- set.casemap -- 	specifies how case of letters is changed
-- set.cdhome -- 	change directory to the home directory by ":cd"
-- set.cedit -- 	key used to open the command-line window

-- set.charconvert -- 	expression for character encoding conversion
-- set.chistory -- 	maximum number of quickfix lists in history
-- set.cindent -- 	do C program indenting
-- set.cinkeys -- 	keys that trigger indent when 'cindent' is set
-- set.cinoptions -- 	how to do indenting when 'cindent' is set
-- set.cinscopedecls -- 	words that are recognized by 'cino-g'
-- set.cinwords -- 	words where 'si' and 'cin' add an indent
-- set.cmdwinheight -- 	height of the command-line window
-- set.colorcolumn = -- 	columns to highlight
-- set.columns -- 	number of columns in the display
-- set.completeslash -- 	like 'shellslash' for completion
-- set.completetimeout -- 	initial decay timeout for CTRL-N and CTRL-P
-- set.concealcursor -- 	whether concealable text is hidden in cursor line
-- set.conceallevel -- 	whether concealable text is shown or hidden
-- set.confirm -- 	ask what to do about unsaved/read-only files
-- set.copyindent -- 	make 'autoindent' use existing indent structure
-- set.cpoptions -- 	flags for Vi-compatible behavior
-- set.cursorbind -- 	move cursor in window as it moves in other windows
-- set.cursorcolumn -- 	highlight the screen column of the cursor
-- set.debug -- 	set to "msg" to see all error messages
-- set.define -- 	pattern to be used to find a macro definition
-- set.delcombine -- 	delete combining characters on their own

-- set.digraph -- 	enable the entering of digraphs in Insert mode
-- set.directory -- 	list of directory names for the swap file
-- set.display -- 	list of flags for how to display text
-- set.eadirection -- 	in which direction 'equalalways' works
-- set.encoding -- 	encoding used internally
-- set.endoffile -- 	write CTRL-Z at end of the file
-- set.endofline -- 	write <EOL> for last line in file
-- set.equalalways -- 	windows are automatically made the same size
-- set.equalprg -- 	external program to use for "=" command
-- set.errorbells -- 	ring the bell for error messages
-- set.errorfile -- 	name of the errorfile for the QuickFix mode
-- set.errorformat -- 	description of the lines in the error file
-- set.eventignore -- 	autocommand events that are ignored
-- set.eventignorewin -- 	autocommand events that are ignored in a window
-- set.exrc -- 	read init files in the current directory
-- set.fileencoding -- 	file encoding for multibyte text
-- set.fileencodings -- 	automatically detected character encodings
-- set.fileformat -- 	file format used for file I/O
-- set.fileformats -- 	automatically detected values for 'fileformat'
-- set.fileignorecase -- 	ignore case when using file names
-- set.filetype -- 	type of file, used for autocommands

-- set.findfunc = function(cmdarg, cmdcomplete) -- 	function to be called for the |:find| command
--   -- Gebruik 'fd' om bestanden op te zoeken
--   -- --type f zoekt alleen naar bestanden
--   -- --hidden optioneel (laat verborgen bestanden weg, tenzij je --hidden toevoegt)
--   -- --exclude .git negeert de .git map
--   local handle = io.popen("fd --type f --strip-cwd-prefix " .. vim.fn.shellescape(cmdarg))
--   if not handle then return {} end
--
--   local result = handle:read("*a")
--   handle:close()
--
--   local files = {}
--   for file in result:gmatch("[^\r\n]+") do
--     table.insert(files, file)
--   end
--
--   return files
-- end

-- set.fixendofline -- 	make sure last line in file has <EOL>
-- set.foldclose -- 	close a fold when the cursor leaves it
-- set.foldcolumn -- 	width of the column used to indicate folds
-- set.foldenable -- 	set to display all folds open
-- set.foldexpr -- 	expression used when 'foldmethod' is "expr"
-- set.foldignore -- 	ignore lines when 'foldmethod' is "indent"
-- set.foldlevel -- 	close folds with a level higher than this
-- set.foldlevelstart -- 	'foldlevel' when starting to edit a file
-- set.foldmarker -- 	markers used when 'foldmethod' is "marker"
-- set.foldmethod -- 	folding type
-- set.foldminlines -- 	minimum number of lines for a fold to be closed
-- set.foldnestmax -- 	maximum fold depth
-- set.foldopen -- 	for which commands a fold will be opened
-- set.foldtext -- 	expression used to display for a closed fold
-- set.formatexpr -- 	expression used with "gq" command
-- set.formatprg -- 	name of external program used with "gq" command
-- set.fsync -- 	whether to invoke fsync() after file write
-- set.grepformat -- 	format of 'grepprg' output

-- set.guifont -- 	GUI: Name(s) of font(s) to be used
-- set.guifontwide -- 	list of font names for double-wide characters
-- set.guioptions -- 	GUI: Which components and options are used
-- set.guitablabel -- 	GUI: custom label for a tabpage
-- set.guitabtooltip -- 	GUI: custom tooltip for a tabpage
-- set.helpfile -- 	full path name of the main help file
-- set.helpheight -- 	minimum height of a new help window
-- set.hidden -- 	don't unload buffer when it is |abandon|ed
-- set.hlsearch -- 	highlight matches with last search pattern
-- set.imcmdline -- 	use IM when starting to edit a command line
-- set.imdisable -- 	do not use the IM in any mode
-- set.iminsert -- 	use :lmap or IM in Insert mode
-- set.imsearch -- 	use :lmap or IM when typing a search pattern
-- set.include -- 	pattern to be used to find an include file
-- set.includeexpr -- 	expression used to process an include line
-- set.incsearch -- 	highlight match while typing search pattern
-- set.indentexpr -- 	expression used to obtain the indent of a line
-- set.indentkeys -- 	keys that trigger indenting with 'indentexpr'
-- set.infercase -- 	adjust case of match for keyword completion
-- set.isfname -- 	characters included in file names and pathnames
-- set.isident -- 	characters included in identifiers
-- set.iskeyword -- 	characters included in keywords
-- set.isprint -- 	printable characters
-- set.joinspaces -- 	two spaces after a period with a join command
-- set.jumpoptions -- 	specifies how jumping is done
-- set.keymap -- 	name of a keyboard mapping
-- set.keymodel -- 	enable starting/stopping selection with keys
-- set.keywordprg -- 	program to use for the "K" command
-- set.langmap -- 	alphabetic characters for other language mode
-- set.langmenu -- 	language to be used for the menus
-- set.langremap -- 	do apply 'langmap' to mapped characters
-- set.laststatus -- 	tells when last window has status lines
-- set.lazyredraw -- 	don't redraw while executing macros
-- set.lhistory -- 	maximum number of location lists in history
-- set.lines -- 	number of lines in the display
-- set.linespace -- 	number of pixel lines to use between characters
-- set.lisp -- 	automatic indenting for Lisp
-- set.lispoptions -- 	changes how Lisp indenting is done
-- set.lispwords -- 	words that change how lisp indenting works
-- 	characters for displaying in list mode
-- set.loadplugins -- 	load plugin scripts when starting up
-- set.makeef -- 	name of the errorfile for ":make"
-- set.makeencoding -- 	encoding of external make/grep commands
-- set.makeprg -- 	program to use for the ":make" command
-- set.matchtime -- 	tenths of a second to show matching paren
-- set.maxcombine -- 	maximum nr of combining characters displayed
-- set.maxfuncdepth -- 	maximum recursive depth for user functions
-- set.maxmapdepth -- 	maximum recursive depth for mapping
-- set.maxmempattern -- 	maximum memory (in Kbyte) used for pattern search
-- set.menuitems -- 	maximum number of items in a menu
-- set.mkspellmem -- 	memory used before |:mkspell| compresses the tree
-- set.modeline -- 	recognize modelines at start or end of file
-- set.modelineexpr -- 	allow setting expression options from a modeline
-- set.modelines -- 	number of lines checked for modelines
-- set.modifiable -- 	changes to the text are not possible
-- set.modified -- 	buffer has been modified
-- set.more -- 	pause listings when the whole screen is filled
-- set.mousefocus -- 	keyboard focus follows the mouse
-- set.mousehide -- 	hide mouse pointer while typing
-- set.mousemodel -- 	changes meaning of mouse buttons
-- set.mousemoveevent -- 	  report mouse moves with <MouseMove>
-- set.mousescroll -- 	amount to scroll by when scrolling with a mouse
-- set.mouseshape -- 	shape of the mouse pointer in different modes
-- set.mousetime -- 	max time between mouse double-click
-- set.nrformats -- 	number formats recognized for CTRL-A command
-- set.numberwidth -- 	number of columns used for the line number
-- set.opendevice -- 	allow reading/writing devices on MS-Windows
-- set.operatorfunc -- 	function to be called for |g@| operator
-- set.packpath -- 	list of directories used for packages
-- set.paragraphs -- 	nroff macros that separate paragraphs
-- set.patchexpr -- 	expression used to patch a file
-- set.patchmode -- 	keep the oldest version of a file
-- set.preserveindent -- 	preserve the indent structure when reindenting
-- set.pyxversion -- 	Python version used for pyx* commands
-- set.quoteescape -- 	escape characters used in a string
-- set.readonly -- 	disallow writing the buffer
-- set.redrawtime -- 	timeout for 'hlsearch' and |:match| highlighting
-- set.regexpengine -- 	default regexp engine to use
-- set.report -- 	threshold for reporting nr. of lines changed
-- set.revins -- 	inserting characters will work backwards
-- set.rightleft -- 	window is right-to-left oriented
-- set.rightleftcmd -- 	commands for which editing works right-to-left
-- set.ruler -- 	show cursor line and column in the status line
-- set.rulerformat -- 	custom format for the ruler
-- set.runtimepath -- 	list of directories used for runtime files
-- set.scroll -- 	lines to scroll with CTRL-U and CTRL-D
-- set.scrollbind -- 	scroll in window as other windows scroll
-- set.scrolljump -- 	minimum number of lines to scroll
-- set.scrolloff -- 	minimum nr. of lines above and below cursor
-- set.scrolloffpad -- 	vertically center cursor at end of file
-- set.scrollopt -- 	how 'scrollbind' should behave
-- set.sections -- 	nroff macros that separate sections
-- set.secure -- 	secure mode for reading .vimrc in current dir
-- set.selection -- 	what type of selection to use
-- set.selectmode -- 	when to use Select mode instead of Visual mode
-- set.sessionoptions -- 	options for |:mksession|
-- set.shell -- 	name of shell to use for external commands
-- set.shellcmdflag -- 	flag to shell to execute one command
-- set.shellpipe -- 	string to put output of ":make" in error file
-- set.shellquote -- 	quote character(s) for around shell command
-- set.shellredir -- 	string to put output of filter in a temp file
-- set.shellslash -- 	use forward slash for shell file names
-- set.shelltemp -- 	whether to use a temp file for shell commands
-- set.shellxescape -- 	characters to escape when 'shellxquote' is (
-- set.shellxquote -- 	like 'shellquote', but include redirection
-- set.shiftround -- 	round indent to multiple of shiftwidth
-- set.shortmess -- 	list of flags, reduce length of messages
-- set.showcmd -- 	show (partial) command somewhere
-- set.showcmdloc -- 	where to show (partial) command
-- set.showfulltag -- 	show full tag pattern when completing tag
-- set.showmode -- 	message on status line to show current mode
-- set.showtabline -- 	tells when the tabpages line is displayed
-- set.sidescroll -- 	minimum number of columns to scroll horizontal
-- set.sidescrolloff -- 	min. nr. of columns to left and right of cursor
-- set.signcolumn -- 	when and how to display the sign column
-- set.smartindent -- 	smart autoindenting for C programs
-- set.smoothscroll -- 	scroll by screen lines when 'wrap' is set
-- set.spelloptions -- 	options for spell checking
-- set.spellsuggest -- 	method(s) used to suggest spelling corrections

-- set.startofline -- 	commands move cursor to first non-blank in line
-- set.suffixes -- 	suffixes that are ignored with multiple match
-- set.suffixesadd -- 	suffixes added when searching for a file
-- set.swapfile -- 	whether to use a swapfile for a buffer
-- set.switchbuf -- 	sets behavior when switching to another buffer
-- set.synmaxcol -- 	maximum column to find syntax items
-- set.syntax -- 	syntax to be loaded for current buffer
-- set.tabclose -- 	which tabpage to focus when closing a tab
-- set.tabline -- 	custom format for the console tabpages line
-- set.tabpagemax -- 	maximum number of tabpages for |-p| and "tab all"
--
--
-- set.term -- 	name of the terminal
-- set.termbidi -- 	terminal takes care of bi-directionality
-- set.textwidth -- 	maximum width of text that is being inserted
-- set.thesaurus -- 	list of thesaurus files for keyword completion
-- set.thesaurusfunc -- 	function to be used for thesaurus completion
-- set.tildeop -- 	tilde command "~" behaves like an operator
-- set.timeout -- 	time out on mappings and key codes
-- set.timeoutlen -- 	time out time in milliseconds
-- set.title -- 	let Vim set the title of the window
-- set.titlelen -- 	percentage of 'columns' used for window title
-- set.titleold -- 	old title, restored when exiting
-- set.titlestring -- 	string to use for the Vim window title
-- set.ttimeout -- 	time out on mappings
-- set.ttimeoutlen -- 	time out time for key codes in milliseconds
-- set.ttytype -- 	alias for 'term'
-- set.undoreload -- 	max nr of lines to save for undo on a buffer reload
-- set.updatecount -- 	after this many characters flush swap file
-- set.updatetime -- 	after this many milliseconds flush swap file
-- set.varsofttabstop -- 	a list of number of columns between soft tab stops
-- set.vartabstop -- 	a list of number of columns between tab stops
-- set.verbose -- 	give informative messages
-- set.verbosefile -- 	file to write messages in
-- set.viewdir -- 	directory where to store files with :mkview
-- set.viewoptions -- 	specifies what to save for :mkview
-- set.wildmenu -- 	use menu for command line completion
-- set.wildmode -- 	mode for 'wildchar' command-line expansion
-- set.winaltkeys -- 	when the windows system handles ALT keys
-- set.window -- 	nr of lines to scroll for CTRL-F and CTRL-B
-- set.winfixbuf -- 	keep window focused on a single buffer
-- set.winfixheight -- 	keep window height when opening/closing windows
-- set.winfixwidth -- 	keep window width when opening/closing windows
-- set.winheight -- 	minimum number of lines for the current window
-- set.winhighlight -- 	window-local highlighting
-- set.winminheight -- 	minimum number of lines for any window
-- set.winminwidth -- 	minimal number of columns for any window
-- set.winwidth -- 	minimal number of columns for current window
-- set.wrap -- 	long lines wrap and continue on the next line
-- set.wrapmargin -- 	chars from the right where wrapping starts
-- set.wrapscan -- 	searches wrap around the end of the file
-- set.write -- 	writing to a file is allowed
-- set.writeany -- 	write to file with no need for "!" override
-- set.writebackup -- 	make a backup before overwriting a file
-- set.writedelay -- 	delay this many msec for each char (for debug)

-- ─────────────────────────────────────────────────────────────────────────────────────────────────
-- 0.0 A
-- set.allowrevins -- 	allow CTRL-_ in Insert mode
-- set.ambiwidth -- 	what to do with Unicode chars of ambiguous width
-- set.arabic -- 	for Arabic as a default second language
-- set.arabicshape -- 	do shaping for Arabic characters
-- set.autochdir -- 	change directory to the file in the current window
-- set.autocompletedelay -- 	delay in msec before menu appears after typing
-- set.autocompletetimeout -- 	initial decay timeout for autocompletion algorithm
-- set.autoindent -- 	take indent for new line from previous line
set.autoread = true -- 	autom. read file when changed outside of Vim
-- set.autowrite -- 	automatically write file if changed
-- set.autowriteall -- 	as 'autowrite', but works with more commands
