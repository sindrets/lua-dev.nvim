--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- The result is a String, which describes the last Visual mode
-- 		used in the current buffer.  Initially it returns an empty
-- 		string, but once Visual mode has been used, it returns "v",
-- 		"V", or "<CTRL-V>" (a single CTRL-V character) for
-- 		character-wise, line-wise, or block-wise Visual mode
-- 		respectively.
-- 		Example: >
-- 			:exe "normal " . visualmode()
-- <		This enters the same Visual mode as before.  It is also useful
-- 		in scripts if you wish to act differently depending on the
-- 		Visual mode that was used.
-- 		If Visual mode is active, use |mode()| to get the Visual mode
-- 		(e.g., in a |:vmap|).
-- 		If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String, then the Visual mode will be cleared and
-- 		the old value is returned.  See |non-zero-arg|.
--- @param expr any?
--- @return string
function vim.fn.visualmode(expr) end

-- This is a unique number, until Vim exits.
--- @return number
function vim.fn.getpid() end

-- Waits for jobs and their |on_exit| handlers to complete.
--
-- 		{jobs} is a List of |job-id|s to wait for.
-- 		{timeout} is the maximum waiting time in milliseconds, -1
-- 		means forever.
--
-- 		Timeout of 0 can be used to check the status of a job: >
-- 			let running = jobwait([{job-id}], 0)[0] == -1
-- <
-- 		During jobwait() callbacks for jobs not in the {jobs} list may
-- 		be invoked. The screen will not redraw unless |:redraw| is
-- 		invoked by a callback.
--
-- 		Returns a list of len({jobs}) integers, where each integer is
-- 		the status of the corresponding job:
-- 			Exit-code, if the job exited
-- 			-1 if the timeout was exceeded
-- 			-2 if the job was interrupted (by |CTRL-C|)
-- 			-3 if the job-id is invalid
--- @param ids any?
--- @param timeout any?
--- @return number
function vim.fn.jobwait(ids, timeout) end

-- Returns |TRUE| when the wildmenu is active and |FALSE|
-- 		otherwise.  See 'wildmenu' and 'wildmode'.
-- 		This can be used in mappings to handle the 'wildcharm' option
-- 		gracefully. (Makes only sense with |mapmode-c| mappings).
--
-- 		For example to make <c-j> work like <down> in wildmode, use: >
--     :cnoremap <expr> <C-j> wildmenumode() ? "\<Down>\<Tab>" : "\<c-j>"
-- <
-- 		(Note, this needs the 'wildcharm' option set appropriately).
--- @return number
function vim.fn.wildmenumode() end

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @param bufnr any?
--- @return list
function vim.fn.win_findbuf(bufnr) end

-- Return the current command-line type. Possible return values
-- 		are:
-- 		    :	normal Ex command
-- 		    >	debug mode command |debug-mode|
-- 		    /	forward search command
-- 		    ?	backward search command
-- 		    @	|input()| command
-- 		    -	|:insert| or |:append| command
-- 		    =	|i_CTRL-R_=|
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns an empty string otherwise.
-- 		Also see |getcmdpos()|, |setcmdpos()| and |getcmdline()|.
--- @return string
function vim.fn.getcmdtype() end

-- Get the |window-ID| for the specified window.
-- 		When {win} is missing use the current window.
-- 		With {win} this is the window number.  The top window has
-- 		number 1.
-- 		Without {tab} use the current tab, otherwise the tab with
-- 		number {tab}.  The first tab has number one.
-- 		Return zero if the window cannot be found.
--- @param win any?
--- @param tab any?
--- @return number
function vim.fn.win_getid(win, tab) end

-- Go to window with ID {expr}.  This may also change the current
-- 		tabpage.
-- 		Return 1 if successful, 0 if the window cannot be found.
--- @param expr any?
--- @return number
function vim.fn.win_gotoid(expr) end

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @param pid any?
--- @return number
function vim.fn.debugbreak(pid) end

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @param expr any?
--- @return list
function vim.fn.win_id2tabwin(expr) end

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @param expr any?
--- @return number
function vim.fn.win_id2win(expr) end

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @param nr any?
--- @return list
function vim.fn.win_screenpos(nr) end

-- Join the items in {list} together into one String.
-- 		When {sep} is specified it is put in between the items.  If
-- 		{sep} is omitted a single space is used.
-- 		Note that {sep} is not added at the end.  You might want to
-- 		add it there too: >
-- 			let lines = join(mylist, "\n") . "\n"
-- <		String items are used as-is.  |Lists| and |Dictionaries| are
-- 		converted into a string like with |string()|.
-- 		The opposite function is |split()|.
--- @param list any?
--- @param sep any?
--- @return string
function vim.fn.join(list, sep) end

-- {not implemented yet}
-- 		Search for a text property as specified with {props}:
-- 		   id		property with this ID
-- 		   type		property with this type name
-- 		   bufnr	buffer to search in; when present a
-- 				start position with "lnum" and "col"
-- 				must be given; when omitted the
-- 				current buffer is used
-- 		   lnum		start in this line (when omitted start
-- 				at the cursor)
-- 		   col		start at this column (when omitted
-- 				and "lnum" is given: use column 1,
-- 				otherwise start at the cursor)
-- 		   skipstart	do not look for a match at the start
-- 				position
--
-- 		{direction} can be "f" for forward and "b" for backward.  When
-- 		omitted forward search is performed.
--
-- 		If a match is found then a Dict is returned with the entries
-- 		as with prop_list(), and additionally an "lnum" entry.
-- 		If no match is found then an empty Dict is returned.
--
-- 		See |text-properties| for information about text properties.
--- @param props any?
--- @param direction any?
--- @return dict
function vim.fn.prop_find(props, direction) end

-- Returns information about windows as a List with Dictionaries.
--
-- 		If {winid} is given Information about the window with that ID
-- 		is returned.  If the window does not exist the result is an
-- 		empty list.
--
-- 		Without {winid} information about all the windows in all the
-- 		tab pages is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			botline		last displayed buffer line
-- 			bufnr		number of buffer in the window
-- 			height		window height (excluding winbar)
-- 			loclist		1 if showing a location list
-- 			quickfix	1 if quickfix or location list window
-- 			terminal	1 if a terminal window
-- 			tabnr		tab page number
-- 			topline		first displayed buffer line
-- 			variables	a reference to the dictionary with
-- 					window-local variables
-- 			width		window width
-- 			winbar		1 if the window has a toolbar, 0
-- 					otherwise
-- 			wincol		leftmost screen column of the window
-- 			winid		|window-ID|
-- 			winnr		window number
-- 			winrow		topmost screen column of the window
--- @param winid any?
--- @return list
function vim.fn.getwininfo(winid) end

-- Returns a Dictionary with information about {job}:
-- 		   "status"	what |job_status()| returns
-- 		   "channel"	what |job_getchannel()| returns
-- 		   "cmd"	List of command arguments used to start the job
-- 		   "process"	process ID
-- 		   "tty_in"	terminal input name, empty when none
-- 		   "tty_out"	terminal output name, empty when none
-- 		   "exitval"	only valid when "status" is "dead"
-- 		   "exit_cb"	function to be called on exit
-- 		   "stoponexit"	|job-stoponexit|
--
-- 		   Only in Unix:
-- 		   "termsig"	the signal which terminated the process
-- 				(See |job_stop()| for the values)
-- 				only valid when "status" is "dead"
--
-- 		   Only in MS-Windows:
-- 		   "tty_type"	Type of virtual console in use.
-- 				Values are "winpty" or "conpty".
-- 				See 'termwintype'.
--
-- 		Without any arguments, returns a List with all Job objects.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_info()
--- @param job any?
--- @return dict
function vim.fn.job_info(job) end

-- Move popup {id} to the position specified with {options}.
-- 		{options} may contain the items from |popup_create()| that
-- 		specify the popup position:
-- 			line
-- 			col
-- 			pos
-- 			maxheight
-- 			minheight
-- 			maxwidth
-- 			minwidth
-- 			fixed
-- 		For {id} see `popup_hide()`.
-- 		For other options see |popup_setoptions()|.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_move(options)
--- @param id any?
--- @param options any?
--- @return none
function vim.fn.popup_move(id, options) end

-- When {pattern} does not match {actual} an error message is
-- 		added to |v:errors|.  Also see |assert-return|.
--
-- 		{pattern} is used as with |=~|: The matching is always done
-- 		like 'magic' was set and 'cpoptions' is empty, no matter what
-- 		the actual value of 'magic' or 'cpoptions' is.
--
-- 		{actual} is used as a string, automatic conversion applies.
-- 		Use "^" and "$" to match with the start and end of the text.
-- 		Use both to match the whole text.
--
-- 		When {msg} is omitted an error in the form
-- 		"Pattern {pattern} does not match {actual}" is produced.
-- 		Example: >
-- 	assert_match('^f.*o$', 'foobar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Pattern '^f.*o$' does not match 'foobar' ~
--- @param pat any?
--- @param text any?
--- @param msg any?
--- @return number
function vim.fn.assert_match(pat, text, msg) end

-- The result is a String, the entry with Number {index} from
-- 		{history}.  See |hist-names| for the possible values of
-- 		{history}, and |:history-indexing| for {index}.  If there is
-- 		no such entry, an empty String is returned.  When {index} is
-- 		omitted, the most recent item from the history is used.
--
-- 		Examples:
-- 		Redo the second last search from history. >
-- 			:execute '/' . histget("search", -2)
--
-- <		Define an Ex command ":H {num}" that supports re-execution of
-- 		the {num}th entry from the output of |:history|. >
-- 			:command -nargs=1 H execute histget("cmd", 0+<args>)
--- @param history any?
--- @param index any?
--- @return string
function vim.fn.histget(history, index) end

-- Set attrs in nvim__buf_set_lua_hl callbacks
--
--                 TODO(bfredl): This is rather pedestrian. The final interface
--                 should probably be derived from a reformed bufhl/virttext
--                 interface with full support for multi-line ranges etc
--- @param id any?
--- @param c0 any?
--- @param c1 any?
--- @return any
function vim.fn.nvim__put_attr(id, c0, c1) end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of bytes in the cursor line plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Additionally {expr} can be [lnum, col]: a |List| with the line
-- 		and column number. Most useful when the column is "$", to get
-- 		the last column of a specific line.  When "lnum" or "col" is
-- 		out of range then col() returns zero.
-- 		To get the line number use |line()|.  To get both use
-- 		|getpos()|.
-- 		For the screen column position use |virtcol()|.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
-- 			col(".")		column of cursor
-- 			col("$")		length of cursor line plus one
-- 			col("'t")		column of mark t
-- 			col("'" . markname)	column of mark markname
-- <		The first column is 1.  0 is returned for an error.
-- 		For an uppercase mark the column may actually be in another
-- 		buffer.
-- 		For the cursor position, when 'virtualedit' is active, the
-- 		column is one higher if the cursor is after the end of the
-- 		line.  This can be used to obtain the column in Insert mode: >
-- 			:imap <F2> <C-O>:let save_ve = &ve<CR>
-- 				\<C-O>:set ve=all<CR>
-- 				\<C-O>:echo col(".") . "\n" <Bar>
-- 				\let &ve = save_ve<CR>
-- <
--- @param expr any?
--- @return number
function vim.fn.col(expr) end

-- The result is a nested List containing the layout of windows
-- 		in a tabpage.
--
-- 		Without {tabnr} use the current tabpage, otherwise the tabpage
-- 		with number {tabnr}. If the tabpage {tabnr} is not found,
-- 		returns an empty list.
--
-- 		For a leaf window, it returns:
-- 			['leaf', {winid}]
-- 		For horizontally split windows, which form a column, it
-- 		returns:
-- 			['col', [{nested list of windows}]]
-- 		For vertically split windows, which form a row, it returns:
-- 			['row', [{nested list of windows}]]
--
-- 		Example: >
-- 			" Only one window in the tab page
-- 			:echo winlayout()
-- 			['leaf', 1000]
-- 			" Two horizontally split windows
-- 			:echo winlayout()
-- 			['col', [['leaf', 1000], ['leaf', 1001]]]
-- 			" Three horizontally split windows, with two
-- 			" vertically split windows in the middle window
-- 			:echo winlayout(2)
-- 			['col', [['leaf', 1002], ['row', ['leaf', 1003],
-- 					     ['leaf', 1001]]], ['leaf', 1000]]
-- <
--- @param tabnr any?
--- @return list
function vim.fn.winlayout(tabnr) end

-- Change options for {job}.  Supported are:
-- 		   "stoponexit"	|job-stoponexit|
-- 		   "exit_cb"	|job-exit_cb|
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_setoptions(options)
--- @param job any?
--- @param options any?
--- @return none
function vim.fn.job_setoptions(job, options) end

-- Start logging channel activity to {fname}.
-- 		When {fname} is an empty string: stop logging.
--
-- 		When {mode} is omitted or "a" append to the file.
-- 		When {mode} is "w" start with an empty file.
--
-- 		Use |ch_log()| to write log messages.  The file is flushed
-- 		after every message, on Unix you can use "tail -f" to see what
-- 		is going on in real time.
--
-- 		This function is not available in the |sandbox|.
-- 		NOTE: the channel communication is stored in the file, be
-- 		aware that this may contain confidential and privacy sensitive
-- 		information, e.g. a password you type in a terminal window.
--
-- 		Can also be used as a |method|: >
-- 			'logfile'->ch_logfile('w')
--- @param fname any?
--- @param mode any?
--- @return none
function vim.fn.ch_logfile(fname, mode) end

-- Put up a file requester.  This only works when "has("browse")"
-- 		returns |TRUE| (only in some GUI versions).
-- 		The input fields are:
-- 		    {save}	when |TRUE|, select file to write
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		    {default}	default file name
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
--- @param save any?
--- @param title any?
--- @param initdir any?
--- @param default any?
--- @return string
function vim.fn.browse(save, title, initdir, default) end

-- Append the item {expr} to |List| {list}.  Returns the
-- 		resulting |List|.  Examples: >
-- 			:let alist = add([1, 2, 3], item)
-- 			:call add(mylist, "woodstock")
-- <		Note that when {expr} is a |List| it is appended as a single
-- 		item.  Use |extend()| to concatenate |Lists|.
-- 		Use |insert()| to add an item at another position.
--- @param list any?
--- @param item any?
--- @return list
function vim.fn.add(list, item) end

-- Returns a list of tags matching the regular expression {expr}.
--
-- 		If {filename} is passed it is used to prioritize the results
-- 		in the same way that |:tselect| does. See |tag-priority|.
-- 		{filename} should be the full path of the file.
--
-- 		Each list item is a dictionary with at least the following
-- 		entries:
-- 			name		Name of the tag.
-- 			filename	Name of the file where the tag is
-- 					defined.  It is either relative to the
-- 					current directory or a full path.
-- 			cmd		Ex command used to locate the tag in
-- 					the file.
-- 			kind		Type of the tag.  The value for this
-- 					entry depends on the language specific
-- 					kind values.  Only available when
-- 					using a tags file generated by
-- 					Exuberant ctags or hdrtag.
-- 			static		A file specific tag.  Refer to
-- 					|static-tag| for more information.
-- 		More entries may be present, depending on the content of the
-- 		tags file: access, implementation, inherits and signature.
-- 		Refer to the ctags documentation for information about these
-- 		fields.  For C code the fields "struct", "class" and "enum"
-- 		may appear, they give the name of the entity the tag is
-- 		contained in.
--
-- 		The ex-command "cmd" can be either an ex search pattern, a
-- 		line number or a line number followed by a byte number.
--
-- 		If there are no matching tags, then an empty list is returned.
--
-- 		To get an exact tag match, the anchors '^' and '$' should be
-- 		used in {expr}.  This also make the function work faster.
-- 		Refer to |tag-regexp| for more information about the tag
-- 		search regular expression pattern.
--
-- 		Refer to |'tags'| for information about how the tags file is
-- 		located by Vim. Refer to |tags-file-format| for the format of
-- 		the tags file generated by the different ctags tools.
--- @param expr any?
--- @param filename any?
--- @return list
function vim.fn.taglist(expr, filename) end

-- Defines a pattern to be highlighted in the current window (a
-- 		"match").  It will be highlighted with {group}.  Returns an
-- 		identification number (ID), which can be used to delete the
-- 		match using |matchdelete()|.
-- 		Matching is case sensitive and magic, unless case sensitivity
-- 		or magicness are explicitly overridden in {pattern}.  The
-- 		'magic', 'smartcase' and 'ignorecase' options are not used.
-- 		The "Conceal" value is special, it causes the match to be
-- 		concealed.
--
-- 		The optional {priority} argument assigns a priority to the
-- 		match.  A match with a high priority will have its
-- 		highlighting overrule that of a match with a lower priority.
-- 		A priority is specified as an integer (negative numbers are no
-- 		exception).  If the {priority} argument is not specified, the
-- 		default priority is 10.  The priority of 'hlsearch' is zero,
-- 		hence all matches with a priority greater than zero will
-- 		overrule it.  Syntax highlighting (see 'syntax') is a separate
-- 		mechanism, and regardless of the chosen priority a match will
-- 		always overrule syntax highlighting.
--
-- 		The optional {id} argument allows the request for a specific
-- 		match ID.  If a specified ID is already taken, an error
-- 		message will appear and the match will not be added.  An ID
-- 		is specified as a positive integer (zero excluded).  IDs 1, 2
-- 		and 3 are reserved for |:match|, |:2match| and |:3match|,
-- 		respectively.  If the {id} argument is not specified or -1,
-- 		|matchadd()| automatically chooses a free ID.
--
-- 		The optional {dict} argument allows for further custom
-- 		values. Currently this is used to specify a match specific
-- 		conceal character that will be shown for |hl-Conceal|
-- 		highlighted matches. The dict can have the following members:
--
-- 			conceal	    Special character to show instead of the
-- 				    match (only for |hl-Conceal| highlighed
-- 				    matches, see |:syn-cchar|)
-- 			window	    Instead of the current window use the
-- 				    window with this number or window ID.
--
-- 		The number of matches is not limited, as it is the case with
-- 		the |:match| commands.
--
-- 		Example: >
-- 			:highlight MyGroup ctermbg=green guibg=green
-- 			:let m = matchadd("MyGroup", "TODO")
-- <		Deletion of the pattern: >
-- 			:call matchdelete(m)
--
-- <		A list of matches defined by |matchadd()| and |:match| are
-- 		available from |getmatches()|.  All matches can be deleted in
-- 		one operation by |clearmatches()|.
--- @param group any?
--- @param pattern any?
--- @param priority any?
--- @param id any?
--- @return number
function vim.fn.matchadd(group, pattern, priority, id) end

-- Get the virtual text (annotation) for a buffer line.
--
--                 The virtual text is returned as list of lists, whereas the
--                 inner lists have either one or two elements. The first element
--                 is the actual text, the optional second element is the
--                 highlight group.
--
--                 The format is exactly the same as given to
--                 nvim_buf_set_virtual_text().
--
--                 If there is no virtual text associated with the given line, an
--                 empty list is returned.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--                     {line}    Line to get the virtual text from (zero-indexed)
--
--                 Return: ~
--                     List of virtual text chunks
--- @param buffer any?
--- @param lnum any?
--- @return any
function vim.fn.nvim_buf_get_virtual_text(buffer, lnum) end

-- {expr1} and {expr2} must be both |Lists| or both
-- 		|Dictionaries|.
--
-- 		If they are |Lists|: Append {expr2} to {expr1}.
-- 		If {expr3} is given insert the items of {expr2} before item
-- 		{expr3} in {expr1}.  When {expr3} is zero insert before the
-- 		first item.  When {expr3} is equal to len({expr1}) then
-- 		{expr2} is appended.
-- 		Examples: >
-- 			:echo sort(extend(mylist, [7, 5]))
-- 			:call extend(mylist, [2, 3], 1)
-- <		When {expr1} is the same List as {expr2} then the number of
-- 		items copied is equal to the original length of the List.
-- 		E.g., when {expr3} is 1 you get N new copies of the first item
-- 		(where N is the original length of the List).
-- 		Use |add()| to concatenate one item to a list.  To concatenate
-- 		two lists into a new list use the + operator: >
-- 			:let newlist = [1, 2, 3] + [4, 5]
-- <
-- 		If they are |Dictionaries|:
-- 		Add all entries from {expr2} to {expr1}.
-- 		If a key exists in both {expr1} and {expr2} then {expr3} is
-- 		used to decide what to do:
-- 		{expr3} = "keep": keep the value of {expr1}
-- 		{expr3} = "force": use the value of {expr2}
-- 		{expr3} = "error": give an error message		*E737*
-- 		When {expr3} is omitted then "force" is assumed.
--
-- 		{expr1} is changed when {expr2} is not empty.  If necessary
-- 		make a copy of {expr1} first.
-- 		{expr2} remains unchanged.
-- 		When {expr1} is locked and {expr2} is not empty the operation
-- 		fails.
-- 		Returns {expr1}.
--- @param expr1 any?
--- @param expr2 any?
--- @param expr3 any?
--- @return list/dict
function vim.fn.extend(expr1, expr2, expr3) end

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

-- The result is a Number, which is 1 if there is a mapping that
-- 		contains {what} in somewhere in the rhs (what it is mapped to)
-- 		and this mapping exists in one of the modes indicated by
-- 		{mode}.
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.  Don't forget to specify Insert and/or
-- 		Command-line mode.
-- 		Both the global mappings and the mappings local to the current
-- 		buffer are checked for a match.
-- 		If no matching mapping is found 0 is returned.
-- 		The following characters are recognized in {mode}:
-- 			n	Normal mode
-- 			v	Visual mode
-- 			o	Operator-pending mode
-- 			i	Insert mode
-- 			l	Language-Argument ("r", "f", "t", etc.)
-- 			c	Command-line mode
-- 		When {mode} is omitted, "nvo" is used.
--
-- 		This function is useful to check if a mapping already exists
-- 		to a function in a Vim script.  Example: >
-- 			:if !hasmapto('\ABCdoit')
-- 			:   map <Leader>d \ABCdoit
-- 			:endif
-- <		This installs the mapping to "\ABCdoit" only if there isn't
-- 		already a mapping to "\ABCdoit".
--- @param what any?
--- @param mode any?
--- @param abbr any?
--- @return number
function vim.fn.hasmapto(what, mode, abbr) end

-- Return |TRUE| if {expr} is a float with value NaN. >
-- 			echo isnan(0.0 / 0.0)
-- <			1
--- @param expr any?
--- @return number
function vim.fn.isnan(expr) end

-- If {id} is a displayed popup, hide it now. If the popup has a
-- 		filter it will not be invoked for so long as the popup is
-- 		hidden.
-- 		If window {id} does not exist nothing happens.  If window {id}
-- 		exists but is not a popup window an error is given. *E993*
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_hide()
--- @param id any?
--- @return none
function vim.fn.popup_hide(id) end

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
--- @param string any?
--- @return any
function vim.fn.js_decode(string) end

-- Evaluate Lua expression {expr} and return its result converted
-- 		to Vim data structures. See |lua-eval| for more details.
--- @param expr any?
--- @param expr any?
--- @return any
function vim.fn.luaeval(expr, expr) end

