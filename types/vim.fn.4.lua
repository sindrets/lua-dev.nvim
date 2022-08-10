--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- The result is the name of a buffer, as it is displayed by the
-- 		":ls" command.
-- +		If {expr} is omitted the current buffer is used.
-- 		If {expr} is a Number, that buffer number's name is given.
-- 		Number zero is the alternate buffer for the current window.
-- 		If {expr} is a String, it is used as a |file-pattern| to match
-- 		with the buffer names.  This is always done like 'magic' is
-- 		set and 'cpoptions' is empty.  When there is more than one
-- 		match an empty string is returned.
-- 		"" or "%" can be used for the current buffer, "#" for the
-- 		alternate buffer.
-- 		A full match is preferred, otherwise a match at the start, end
-- 		or middle of the buffer name is accepted.  If you only want a
-- 		full match then put "^" at the start and "$" at the end of the
-- 		pattern.
-- 		Listed buffers are found first.  If there is a single match
-- 		with a listed buffer, that one is returned.  Next unlisted
-- 		buffers are searched for.
-- 		If the {expr} is a String, but you want to use it as a buffer
-- 		number, force it to be a Number by adding zero to it: >
-- 			:echo bufname("3" + 0)
-- <		If the buffer doesn't exist, or doesn't have a name, an empty
-- 		string is returned. >
-- 	bufname("#")		alternate buffer name
-- 	bufname(3)		name of buffer 3
-- 	bufname("%")		name of current buffer
-- 	bufname("file2")	name of buffer where "file2" matches.
--- @param expr any?
--- @return string
function vim.fn.bufname(expr) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the first line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @param lnum any?
--- @return number
function vim.fn.foldclosed(lnum) end

-- Same as |match()|, but return a |List|.  The first item in the
-- 		list is the matched string, same as what matchstr() would
-- 		return.  Following items are submatches, like "\1", "\2", etc.
-- 		in |:substitute|.  When an optional submatch didn't match an
-- 		empty string is used.  Example: >
-- 			echo matchlist('acd', '\(a\)\?\(b\)\?\(c\)\?\(.*\)')
-- <		Results in: ['acd', 'a', '', 'c', 'd', '', '', '', '', '']
-- 		When there is no match an empty list is returned.
--- @param expr any?
--- @param pat any?
--- @param start any?
--- @param count any?
--- @return list
function vim.fn.matchlist(expr, pat, start, count) end

-- Return {text} as a String where any character in {mask} is
-- 		removed from the beginning and  end of {text}.
-- 		If {mask} is not given, {mask} is all characters up to 0x20,
-- 		which includes Tab, space, NL and CR, plus the non-breaking
-- 		space character 0xa0.
-- 		This code deals with multibyte characters properly.
--
-- 		Examples: >
-- 			echo trim("   some text ")
-- <		returns "some text" >
-- 			echo trim("  \r\t\t\r RESERVE \t\n\x0B\xA0") . "_TAIL"
-- <		returns "RESERVE_TAIL" >
-- 			echo trim("rm<Xrm<>X>rrm", "rm<>")
-- <		returns "Xrm<>X" (characters in the middle are not removed)
--- @param text any?
--- @param mask any?
--- @return string
function vim.fn.trim(text, mask) end

-- Get the contents of {row} of terminal screen of {buf}.
-- 		For {buf} see |term_getsize()|.
--
-- 		The first line has {row} one.  When {row} is "." the cursor
-- 		line is used.  When {row} is invalid an empty string is
-- 		returned.
--
-- 		Return a List containing a Dict for each screen cell:
-- 		    "chars"	character(s) at the cell
-- 		    "fg"	foreground color as #rrggbb
-- 		    "bg"	background color as #rrggbb
-- 		    "attr"	attributes of the cell, use |term_getattr()|
-- 				to get the individual flags
-- 		    "width"	cell width: 1 or 2
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_scrape(row)
--- @param buf any?
--- @param row any?
--- @return list
function vim.fn.term_scrape(buf, row) end

-- Same as |match()|, but return the index of first character
-- 		after the match.  Example: >
-- 			:echo matchend("testing", "ing")
-- <		results in "7".
-- 							*strspn()* *strcspn()*
-- 		Vim doesn't have a strspn() or strcspn() function, but you can
-- 		do it with matchend(): >
-- 			:let span = matchend(line, '[a-zA-Z]')
-- 			:let span = matchend(line, '[^a-zA-Z]')
-- <		Except that -1 is returned when there are no matches.
--
-- 		The {start}, if given, has the same meaning as for |match()|. >
-- 			:echo matchend("testing", "ing", 2)
-- <		results in "7". >
-- 			:echo matchend("testing", "ing", 5)
-- <		result is "-1".
-- 		When {expr} is a |List| the result is equal to |match()|.
--- @param expr any?
--- @param pat any?
--- @param start any?
--- @param count any?
--- @return number
function vim.fn.matchend(expr, pat, start, count) end

-- Set prompt callback for buffer {buf} to {expr}.  When {expr}
-- 		is an empty string the callback is removed.  This has only
-- 		effect if {buf} has 'buftype' set to "prompt".
--
-- 		The callback is invoked when pressing Enter.  The current
-- 		buffer will always be the prompt buffer.  A new line for a
-- 		prompt is added before invoking the callback, thus the prompt
-- 		for which the callback was invoked will be in the last but one
-- 		line.
-- 		If the callback wants to add text to the buffer, it must
-- 		insert it above the last line, since that is where the current
-- 		prompt is.  This can also be done asynchronously.
-- 		The callback is invoked with one argument, which is the text
-- 		that was entered at the prompt.  This can be an empty string
-- 		if the user only typed Enter.
-- 		Example: >
-- 		   call prompt_setcallback(bufnr(''), function('s:TextEntered'))
-- 		   func s:TextEntered(text)
-- 		     if a:text == 'exit' || a:text == 'quit'
-- 		       stopinsert
-- 		       close
-- 		     else
-- 		       call append(line('$') - 1, 'Entered: "' . a:text . '"')
-- 		       " Reset 'modified' to allow the buffer to be closed.
-- 		       set nomodified
-- 		     endif
-- 		   endfunc
--- @param buf any?
--- @param expr any?
--- @return none
function vim.fn.prompt_setcallback(buf, expr) end

-- The result is a Number, which is the current screen row of the
-- 		cursor.  The top line has number one.
-- 		This function is mainly used for testing.
-- 		Alternatively you can use |winline()|.
--
-- 		Note: Same restrictions as with |screencol()|.
--- @return number
function vim.fn.screenrow() end

-- Deletes a match with ID {id} previously defined by |matchadd()|
-- 		or one of the |:match| commands.  Returns 0 if successful,
-- 		otherwise -1.  See example for |matchadd()|.  All matches can
-- 		be deleted in one operation by |clearmatches()|.
--- @param id any?
--- @return number
function vim.fn.matchdelete(id) end

-- Return the byte count from the start of the buffer for line
-- 		{lnum}.  This includes the end-of-line character, depending on
-- 		the 'fileformat' option for the current buffer.  The first
-- 		line returns 1. UTF-8 encoding is used, 'fileencoding' is
-- 		ignored.  This can also be used to get the byte count for the
-- 		line just below the last line: >
-- 			line2byte(line("$") + 1)
-- <		This is the buffer size plus one.  If 'fileencoding' is empty
-- 		it is the file size plus one.
-- 		When {lnum} is invalid -1 is returned.
-- 		Also see |byte2line()|, |go| and |:goto|.
--- @param lnum any?
--- @return number
function vim.fn.line2byte(lnum) end

-- This is similar to |json_encode()| with these differences:
-- 		- Object key names are not in quotes.
-- 		- v:none items in an array result in an empty item between
-- 		  commas.
-- 		For example, the Vim object:
-- 			[1,v:none,{"one":1},v:none] ~
-- 		Will be encoded as:
-- 			[1,,{one:1},,] ~
-- 		While json_encode() would produce:
-- 			[1,null,{"one":1},null] ~
-- 		This encoding is valid for JavaScript. It is more efficient
-- 		than JSON, especially when using an array with optional items.
--
-- 		Can also be used as a |method|: >
-- 			GetObject()->js_encode()
--- @param expr any?
--- @return string
function vim.fn.js_encode(expr) end

-- Returns a |Dictionary| representing the |context| at {index}
-- 		from the top of the |context-stack| (see |context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @param index any?
--- @return dict
function vim.fn.ctxget(index) end

-- Activates UI events on the channel.
--
--                 Entry point of all UI clients. Allows |--embed| to continue
--                 startup. Implies that the client is ready to show the UI. Adds
--                 the client to the list of UIs. |nvim_list_uis()|
--
--                 Note:
--                     If multiple UI clients are attached, the global screen
--                     dimensions degrade to the smallest client. E.g. if client
--                     A requests 80x40 but client B requests 200x100, the global
--                     screen has size 80x40.
--
--                 Parameters: ~
--                     {width}    Requested screen columns
--                     {height}   Requested screen rows
--                     {options}  |ui-option| map
--- @param width any?
--- @param height any?
--- @param options any?
--- @return any
function vim.fn.nvim_ui_attach(width, height, options) end

-- The result is the swap file path of the buffer {expr}.
-- 		For the use of {expr}, see |bufname()| above.
-- 		If buffer {expr} is the current buffer, the result is equal to
-- 		|:swapname| (unless no swap file).
-- 		If buffer {expr} has no swap file, returns an empty string.
--- @param expr any?
--- @return string
function vim.fn.swapname(expr) end

-- Like ch_read() but for a JS and JSON channel does not decode
-- 		the message.  For a NL channel it does not block waiting for
-- 		the NL to arrive, but otherwise works like ch_read().
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readraw()
--- @param handle any?
--- @param options any?
--- @return string
function vim.fn.ch_readraw(handle, options) end

-- Set a callback for buffer {buf} to {expr}.  When {expr} is an
-- 		empty string the callback is removed.  This has only effect if
-- 		{buf} has 'buftype' set to "prompt".
--
-- 		This callback will be invoked when pressing CTRL-C in Insert
-- 		mode.  Without setting a callback Vim will exit Insert mode,
-- 		as in any buffer.
--- @param buf any?
--- @param text any?
--- @return none
function vim.fn.prompt_setinterrupt(buf, text) end

-- Set the text of the buffer in popup win {id}. {text} is the
-- 		same as supplied to |popup_create()|, except that a buffer
-- 		number is not allowed.
-- 		Does not change the window size or position, other than caused
-- 		by the different text.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_settext('hello')
--- @param id any?
--- @param text any?
--- @return none
function vim.fn.popup_settext(id, text) end

-- The result is a Number, which is the foldlevel of line {lnum}
-- 		in the current buffer.  For nested folds the deepest level is
-- 		returned.  If there is no fold at line {lnum}, zero is
-- 		returned.  It doesn't matter if the folds are open or closed.
-- 		When used while updating folds (from 'foldexpr') -1 is
-- 		returned for lines where folds are still to be updated and the
-- 		foldlevel is unknown.  As a special case the level of the
-- 		previous line is usually available.
--- @param lnum any?
--- @return number
function vim.fn.foldlevel(lnum) end

-- Without {end}: Remove the item at {idx} from |List| {list} and
-- 		return the item.
-- 		With {end}: Remove items from {idx} to {end} (inclusive) and
-- 		return a List with these items.  When {idx} points to the same
-- 		item as {end} a list with one item is returned.  When {end}
-- 		points to an item before {idx} this is an error.
-- 		See |list-index| for possible values of {idx} and {end}.
-- 		Example: >
-- 			:echo "last item: " . remove(mylist, -1)
-- 		Remove the entry from {dict} with key {key} and return it.
-- 		Example: >
-- 			:echo "removed " . remove(dict, "one")
-- <		If there is no {key} in {dict} this is an error.
--
-- 		Use |delete()| to remove a file.
--- @param dict dictionary?
--- @param key any?
--- @return any
function vim.fn.remove(dict, key) end

-- The result is the {nr}th file in the argument list.  See
-- 		|arglist|.  "argv(0)" is the first one.  Example: >
-- 	:let i = 0
-- 	:while i < argc()
-- 	:  let f = escape(fnameescape(argv(i)), '.')
-- 	:  exe 'amenu Arg.' . f . ' :e ' . f . '<CR>'
-- 	:  let i = i + 1
-- 	:endwhile
-- <		Without the {nr} argument, or when {nr} is -1, a |List| with
-- 		the whole |arglist| is returned.
--
-- 		The {winid} argument specifies the window ID, see |argc()|.
--- @param _1 any?
--- @param winid any?
--- @return list
function vim.fn.argv(_1, winid) end

-- Return a string which contains characters indicating the
-- 		current state.  Mostly useful in callbacks that want to do
-- 		work that may not always be safe.  Roughly this works like:
-- 		- callback uses state() to check if work is safe to do.
-- 		  Yes: then do it right away.
-- 		  No:  add to work queue and add a |SafeState| and/or
-- 		       |SafeStateAgain| autocommand (|SafeState| triggers at
-- 		       toplevel, |SafeStateAgain| triggers after handling
-- 		       messages and callbacks).
-- 		- When SafeState or SafeStateAgain is triggered and executes
-- 		  your autocommand, check with `state()` if the work can be
-- 		  done now, and if yes remove it from the queue and execute.
-- 		  Remove the autocommand if the queue is now empty.
-- 		Also see |mode()|.
--
-- 		When {what} is given only characters in this string will be
-- 		added.  E.g, this checks if the screen has scrolled: >
-- 			if state('s') == ''
-- 			   " screen has not scrolled
-- <
-- 		These characters indicate the state, generally indicating that
-- 		something is busy:
-- 		    m	halfway a mapping, :normal command, feedkeys() or
-- 			stuffed command
-- 		    o	operator pending or waiting for a command argument,
-- 		        e.g. after |f|
-- 		    a	Insert mode autocomplete active
-- 		    x	executing an autocommand
-- 		    w	blocked on waiting, e.g. ch_evalexpr(), ch_read() and
-- 			ch_readraw() when reading json.
-- 		    S	not triggering SafeState or SafeStateAgain
-- 		    c	callback invoked, including timer (repeats for
-- 			recursiveness up to "ccc")
-- 		    s	screen has scrolled for messages
--- @param what any?
--- @return string
function vim.fn.state(what) end

-- Make a copy of {expr}.  For Numbers and Strings this isn't
-- 		different from using {expr} directly.
-- 		When {expr} is a |List| a full copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  When an item is a |List|, a copy for it
-- 		is made, recursively.  Thus changing an item in the copy does
-- 		not change the contents of the original |List|.
-- 		When {noref} is omitted or zero a contained |List| or
-- 		|Dictionary| is only copied once.  All references point to
-- 		this single copy.  With {noref} set to 1 every occurrence of a
-- 		|List| or |Dictionary| results in a new copy.  This also means
-- 		that a cyclic reference causes deepcopy() to fail.
-- 								*E724*
-- 		Nesting is possible up to 100 levels.  When there is an item
-- 		that refers back to a higher level making a deep copy with
-- 		{noref} set to 1 will fail.
-- 		Also see |copy()|.
--- @param expr any?
--- @param noref any?
--- @return any
function vim.fn.deepcopy(expr, noref) end

-- This function acts much like the |input()| function with but
-- 		two exceptions:
-- 		a) the user's response will be displayed as a sequence of
-- 		asterisks ("*") thereby keeping the entry secret, and
-- 		b) the user's response will not be recorded on the input
-- 		|history| stack.
-- 		The result is a String, which is whatever the user actually
-- 		typed on the command-line in response to the issued prompt.
-- 		NOTE: Command-line completion is not supported.
--- @param prompt any?
--- @param text any?
--- @return string
function vim.fn.inputsecret(prompt, text) end

-- Checks for the existence of a |cscope| connection.  If no
-- 		parameters are specified, then the function returns:
-- 			0, if cscope was not available (not compiled in), or
-- 			   if there are no cscope connections;
-- 			1, if there is at least one cscope connection.
--
-- 		If parameters are specified, then the value of {num}
-- 		determines how existence of a cscope connection is checked:
--
-- 		{num}	Description of existence check
-- 		-----	------------------------------
-- 		0	Same as no parameters (e.g., "cscope_connection()").
-- 		1	Ignore {prepend}, and use partial string matches for
-- 			{dbpath}.
-- 		2	Ignore {prepend}, and use exact string matches for
-- 			{dbpath}.
-- 		3	Use {prepend}, use partial string matches for both
-- 			{dbpath} and {prepend}.
-- 		4	Use {prepend}, use exact string matches for both
-- 			{dbpath} and {prepend}.
--
-- 		Note: All string comparisons are case sensitive!
--
-- 		Examples.  Suppose we had the following (from ":cs show"): >
--
--   # pid    database name			prepend path
--   0 27664  cscope.out				/usr/local
-- <
-- 		Invocation					Return Val ~
-- 		----------					---------- >
-- 		cscope_connection()					1
-- 		cscope_connection(1, "out")				1
-- 		cscope_connection(2, "out")				0
-- 		cscope_connection(3, "out")				0
-- 		cscope_connection(3, "out", "local")			1
-- 		cscope_connection(4, "out")				0
-- 		cscope_connection(4, "out", "local")			0
-- 		cscope_connection(4, "cscope.out", "/usr/local")	1
-- <
--- @param num any?
--- @param dbpath any?
--- @param prepend any?
--- @return number
function vim.fn.cscope_connection(num, dbpath, prepend) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the last line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @param lnum any?
--- @return number
function vim.fn.foldclosedend(lnum) end

-- If {id} is a hidden popup, show it now.
-- 		For {id} see `popup_hide()`.
-- 		If {id} is the info popup it will be positioned next to the
-- 		current popup menu item.
--- @param id any?
--- @return none
function vim.fn.popup_show(id) end

-- Invoke listener callbacks for buffer {buf}.  If there are no
-- 		pending changes then no callbacks are invoked.
--
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
--
-- 		Can also be used as a |method|: >
-- 			GetBuffer()->listener_flush()
--- @param buf any?
--- @return none
function vim.fn.listener_flush(buf) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

-- The result is a Number, which is |TRUE| when the IME status is
-- 		active.
-- 		See 'imstatusfunc'.
--- @return number
function vim.fn.getimstatus() end

-- Returns a Dictionary with information about {handle}.  The
-- 		items are:
-- 		   "id"		  number of the channel
-- 		   "status"	  "open", "buffered" or "closed", like
-- 				  ch_status()
-- 		When opened with ch_open():
-- 		   "hostname"	  the hostname of the address
-- 		   "port"	  the port of the address
-- 		   "sock_status"  "open" or "closed"
-- 		   "sock_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "sock_io"	  "socket"
-- 		   "sock_timeout" timeout in msec
-- 		When opened with job_start():
-- 		   "out_status"	  "open", "buffered" or "closed"
-- 		   "out_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "out_io"	  "null", "pipe", "file" or "buffer"
-- 		   "out_timeout"  timeout in msec
-- 		   "err_status"	  "open", "buffered" or "closed"
-- 		   "err_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "err_io"	  "out", "null", "pipe", "file" or "buffer"
-- 		   "err_timeout"  timeout in msec
-- 		   "in_status"	  "open" or "closed"
-- 		   "in_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "in_io"	  "null", "pipe", "file" or "buffer"
-- 		   "in_timeout"	  timeout in msec
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_info()
--- @param handle any?
--- @return string
function vim.fn.ch_info(handle) end

-- Characters in {string} are queued for processing as if they
-- 		come from a mapping or were typed by the user.
--
-- 		By default the string is added to the end of the typeahead
-- 		buffer, thus if a mapping is still being executed the
-- 		characters come after them.  Use the 'i' flag to insert before
-- 		other characters, they will be executed next, before any
-- 		characters from a mapping.
--
-- 		The function does not wait for processing of keys contained in
-- 		{string}.
--
-- 		To include special keys into {string}, use double-quotes
-- 		and "\..." notation |expr-quote|. For example,
-- 		feedkeys("\<CR>") simulates pressing of the <Enter> key. But
-- 		feedkeys('\<CR>') pushes 5 characters.
-- 		The |<Ignore>| keycode may be used to exit the
-- 		wait-for-character without doing anything.
--
-- 		{mode} is a String, which can contain these character flags:
-- 		'm'	Remap keys. This is default.  If {mode} is absent,
-- 			keys are remapped.
-- 		'n'	Do not remap keys.
-- 		't'	Handle keys as if typed; otherwise they are handled as
-- 			if coming from a mapping.  This matters for undo,
-- 			opening folds, etc.
-- 		'i'	Insert the string instead of appending (see above).
-- 		'x'	Execute commands until typeahead is empty.  This is
-- 			similar to using ":normal!".  You can call feedkeys()
-- 			several times without 'x' and then one time with 'x'
-- 			(possibly with an empty {string}) to execute all the
-- 			typeahead.  Note that when Vim ends in Insert mode it
-- 			will behave as if <Esc> is typed, to avoid getting
-- 			stuck, waiting for a character to be typed before the
-- 			script continues.
-- 			Note that if you manage to call feedkeys() while
-- 			executing commands, thus calling it recursively, the
-- 			all typehead will be consumed by the last call.
-- 		'!'	When used with 'x' will not end Insert mode. Can be
-- 			used in a test when a timer is set to exit Insert mode
-- 			a little later.  Useful for testing CursorHoldI.
--
-- 		Return value is always 0.
--- @param string any?
--- @param mode any?
--- @return number
function vim.fn.feedkeys(string, mode) end

-- The result is a Number, which is the number of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinnr(1))
--
-- <		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Only deals with the current tab page.
--- @param expr any?
--- @return number
function vim.fn.bufwinnr(expr) end

-- The result is a copy of the {src} string with all characters
-- 		which appear in {fromstr} replaced by the character in that
-- 		position in the {tostr} string.  Thus the first character in
-- 		{fromstr} is translated into the first character in {tostr}
-- 		and so on.  Exactly like the unix "tr" command.
-- 		This code also deals with multibyte characters properly.
--
-- 		Examples: >
-- 			echo tr("hello there", "ht", "HT")
-- <		returns "Hello THere" >
-- 			echo tr("<blob>", "<>", "{}")
-- <		returns "{blob}"
--- @param src any?
--- @param fromstr any?
--- @param tostr any?
--- @return string
function vim.fn.tr(src, fromstr, tostr) end

-- Return a |List| with all the key-value pairs of {dict}.  Each
-- 		|List| item is a list with two items: the key of a {dict}
-- 		entry and the value of this entry.  The |List| is in arbitrary
-- 		order.
--- @param dict dictionary?
--- @return list
function vim.fn.items(dict) end

-- for the current buffer.  This is the 'tags' option expanded.
--- @return list
function vim.fn.tagfiles() end

-- Return a pseudo-random Number generated with an xoshiro128**
-- 		algorithm using seed {expr}.  The returned number is 32 bits,
-- 		also on 64 bits systems, for consistency.
-- 		{expr} can be initialized by |srand()| and will be updated by
-- 		rand().  If {expr} is omitted, an internal seed value is used
-- 		and updated.
--
-- 		Examples: >
-- 			:echo rand()
-- 			:let seed = srand()
-- 			:echo rand(seed)
-- 			:echo rand(seed) % 16  " random number 0 - 15
-- <
--- @param expr any?
--- @return number
function vim.fn.rand(expr) end

-- Add a callback function that will be invoked when changes have
-- 		been made to buffer {buf}.
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
-- 		Returns a unique ID that can be passed to |listener_remove()|.
--
-- 		The {callback} is invoked with five arguments:
-- 		    a:bufnr	the buffer that was changed
-- 		    a:start	first changed line number
-- 		    a:end	first line number below the change
-- 		    a:added	number of lines added, negative if lines were
-- 				deleted
-- 		    a:changes	a List of items with details about the changes
--
-- 		Example: >
-- 	    func Listener(bufnr, start, end, added, changes)
-- 	      echo 'lines ' .. a:start .. ' until ' .. a:end .. ' changed'
-- 	    endfunc
-- 	    call listener_add('Listener', bufnr)
--
-- <		The List cannot be changed.  Each item in a:changes is a
-- 		dictionary with these entries:
-- 		    lnum	the first line number of the change
-- 		    end		the first line below the change
-- 		    added	number of lines added; negative if lines were
-- 				deleted
-- 		    col		first column in "lnum" that was affected by
-- 				the change; one if unknown or the whole line
-- 				was affected; this is a byte index, first
-- 				character has a value of one.
-- 		When lines are inserted the values are:
-- 		    lnum	line above which the new line is added
-- 		    end		equal to "lnum"
-- 		    added	number of lines inserted
-- 		    col		1
-- 		When lines are deleted the values are:
-- 		    lnum	the first deleted line
-- 		    end		the line below the first deleted line, before
-- 				the deletion was done
-- 		    added	negative, number of lines deleted
-- 		    col		1
-- 		When lines are changed:
-- 		    lnum	the first changed line
-- 		    end		the line below the last changed line
-- 		    added	0
-- 		    col		first column with a change or 1
--
-- 		The entries are in the order the changes were made, thus the
-- 		most recent change is at the end.  The line numbers are valid
-- 		when the callback is invoked, but later changes may make them
-- 		invalid, thus keeping a copy for later might not work.
--
-- 		The {callback} is invoked just before the screen is updated,
-- 		when |listener_flush()| is called or when a change is being
-- 		made that changes the line count in a way it causes a line
-- 		number in the list of changes to become invalid.
--
-- 		The {callback} is invoked with the text locked, see
-- 		|textlock|.  If you do need to make changes to the buffer, use
-- 		a timer to do this later |timer_start()|.
--
-- 		The {callback} is not invoked when the buffer is first loaded.
-- 		Use the |BufReadPost| autocmd event to handle the initial text
-- 		of a buffer.
-- 		The {callback} is also not invoked when the buffer is
-- 		unloaded, use the |BufUnload| autocmd event for that.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetBuffer()->listener_add(callback)
--- @param callback any?
--- @param buf any?
--- @return number
function vim.fn.listener_add(callback, buf) end

-- Return a Float that represents the time value of {time}.
-- 		Unit of time is seconds.
-- 		Example:
-- 			let start = reltime()
-- 			call MyFunction()
-- 			let seconds = reltimefloat(reltime(start))
-- 		See the note of reltimestr() about overhead.
--  		Also see |profiling|.
--- @param time any?
--- @return float
function vim.fn.reltimefloat(time) end

-- Create directory {name}.
-- 		If {path} is "p" then intermediate directories are created as
-- 		necessary.  Otherwise it must be "".
-- 		If {prot} is given it is used to set the protection bits of
-- 		the new directory.  The default is 0755 (rwxr-xr-x: r/w for
-- 		the user readable for others).  Use 0700 to make it unreadable
-- 		for others.
--
-- 		{prot} is applied for all parts of {name}.  Thus if you create
-- 		/tmp/foo/bar then /tmp/foo will be created with 0700. Example: >
-- 			:call mkdir($HOME . "/tmp/foo/bar", "p", 0700)
-- <		This function is not available in the |sandbox|.
--
-- 		If you try to create an existing directory with {path} set to
-- 		"p" mkdir() will silently exit.
--- @param name any?
--- @param path any?
--- @param prot any?
--- @return number
function vim.fn.mkdir(name, path, prot) end

-- Return number value of the first char in {expr}.  Examples: >
-- 			char2nr(" ")		returns 32
-- 			char2nr("ABC")		returns 65
-- 			char2nr("á")		returns 225
-- 			char2nr("á"[0])		returns 195
-- 			char2nr("\<M-x>")	returns 128
-- <		Non-ASCII characters are always treated as UTF-8 characters.
-- 		{utf8} is ignored, it exists only for backwards-compatibility.
-- 		A combining character is a separate character.
-- 		|nr2char()| does the opposite.
--- @param expr any?
--- @param utf8 any?
--- @return number
function vim.fn.char2nr(expr, utf8) end

-- {textlist} must be a |List| of strings.  This |List| is
-- 		displayed, one string per line.  The user will be prompted to
-- 		enter a number, which is returned.
-- 		The user can also select an item by clicking on it with the
-- 		mouse.  For the first string 0 is returned.  When clicking
-- 		above the first item a negative number is returned.  When
-- 		clicking on the prompt one more than the length of {textlist}
-- 		is returned.
-- 		Make sure {textlist} has less than 'lines' entries, otherwise
-- 		it won't work.  It's a good idea to put the entry number at
-- 		the start of the string.  And put a prompt in the first item.
-- 		Example: >
-- 			let color = inputlist(['Select color:', '1. red',
-- 				\ '2. green', '3. blue'])
--- @param textlist any?
--- @return number
function vim.fn.inputlist(textlist) end

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary?
--- @param key any?
--- @return number
function vim.fn.has_key(dict, key) end

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @param id any?
--- @param key any?
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

-- Show the {what} above the position from 'ballooneval' and
-- 		close it when the mouse moves.  This works like: >
-- 		  let pos = screenpos(v:beval_winnr, v:beval_lnum, v:beval_col)
-- 		  call popup_create({what}, #{
-- 			\ pos: 'botleft',
-- 			\ line: pos.row - 1,
-- 			\ col: pos.col,
-- 			\ mousemoved: 'WORD',
-- 			\ })
-- <		Use {options} to change the properties.
-- 		See |popup_beval_example| for an example.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_beval({})
-- <
--- @param what any?
--- @param options any?
--- @return number
function vim.fn.popup_beval(what, options) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.  See |channel-use|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 								*E917*
-- 		{options} must be a Dictionary.  It must not have a "callback"
-- 		entry.  It can have a "timeout" entry to specify the timeout
-- 		for this specific request.
--
-- 		ch_evalexpr() waits for a response and returns the decoded
-- 		expression.  When there is an error or timeout it returns an
-- 		empty string.
--
-- 		Note that while waiting for the response, Vim handles other
-- 		messages.  You need to make sure this doesn't cause trouble.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalexpr(expr)
--- @param handle any?
--- @param expr any?
--- @param options any?
--- @return any
function vim.fn.ch_evalexpr(handle, expr, options) end

-- Given {attr}, a value returned by term_scrape() in the "attr"
-- 		item, return whether {what} is on.  {what} can be one of:
-- 			bold
-- 			italic
-- 			underline
-- 			strike
-- 			reverse
--
-- 		Can also be used as a |method|: >
-- 			GetAttr()->term_getattr()
--- @param attr any?
--- @param what any?
--- @return number
function vim.fn.term_getattr(attr, what) end

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @param expr any?
--- @param create any?
--- @return number
function vim.fn.bufnr(expr, create) end

-- Set line {lnum} to {text} in buffer {expr}.  To insert
-- 		lines use |append()|.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		{lnum} is used like with |setline()|.
-- 		This works like |setline()| for the specified buffer.
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		If {expr} is not a valid buffer or {lnum} is not valid, an
-- 		error message is given.
--- @param expr any?
--- @param lnum any?
--- @param line any?
--- @return number
function vim.fn.setbufline(expr, lnum, line) end

-- Set the ANSI color palette used by terminal {buf}.
-- 		{colors} must be a List of 16 valid color names or hexadecimal
-- 		color codes, like those accepted by |highlight-guifg|.
-- 		Also see |term_getansicolors()| and |g:terminal_ansi_colors|.
--
-- 		The colors normally are:
-- 			0    black
-- 			1    dark red
-- 			2    dark green
-- 			3    brown
-- 			4    dark blue
-- 			5    dark magenta
-- 			6    dark cyan
-- 			7    light grey
-- 			8    dark grey
-- 			9    red
-- 			10   green
-- 			11   yellow
-- 			12   blue
-- 			13   magenta
-- 			14   cyan
-- 			15   white
--
-- 		These colors are used in the GUI and in the terminal when
-- 		'termguicolors' is set.  When not using GUI colors (GUI mode
-- 		or 'termguicolors'), the terminal window always uses the 16
-- 		ANSI colors of the underlying terminal.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setansicolors(colors)
--
-- <		{only available with GUI enabled and/or the |+termguicolors|
-- 		feature}
--- @param buf any?
--- @param colors any?
--- @return none
function vim.fn.term_setansicolors(buf, colors) end

-- Set option or local variable {varname} in buffer {expr} to
-- 		{val}.
-- 		This also works for a global or local window option, but it
-- 		doesn't work for a global or local window variable.
-- 		For a local window option the global value is unchanged.
-- 		For the use of {expr}, see |bufname()| above.
-- 		Note that the variable name without "b:" must be used.
-- 		Examples: >
-- 			:call setbufvar(1, "&mod", 1)
-- 			:call setbufvar("todo", "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @param expr any?
--- @param varname any?
--- @param val any?
--- @return set
function vim.fn.setbufvar(expr, varname, val) end

-- Set the current character search information to {dict},
-- 		which contains one or more of the following entries:
--
-- 		    char	character which will be used for a subsequent
-- 				|,| or |;| command; an empty string clears the
-- 				character search
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to save/restore a user's character search
-- 		from a script: >
-- 			:let prevsearch = getcharsearch()
-- 			:" Perform a command which clobbers user's search
-- 			:call setcharsearch(prevsearch)
-- <		Also see |getcharsearch()|.
--- @param dict dictionary?
--- @return dict
function vim.fn.setcharsearch(dict) end

-- Return a List with all text properties in line {lnum}.
--
-- 		When {props} contains a "bufnr" item, use this buffer instead
-- 		of the current buffer.
--
-- 		The properties are ordered by starting column and priority.
-- 		Each property is a Dict with these entries:
-- 		   col		starting column
-- 		   length	length in bytes, one more if line break is
-- 				included
-- 		   id		property ID
-- 		   type		name of the property type, omitted if
-- 				the type was deleted
-- 		   start	when TRUE property starts in this line
-- 		   end		when TRUE property ends in this line
--
-- 		When "start" is zero the property started in a previous line,
-- 		the current one is a continuation.
-- 		When "end" is zero the property continues in the next line.
-- 		The line break after this line is included.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_list()
-- <
--- @param lnum any?
--- @param props any?
--- @return list
function vim.fn.prop_list(lnum, props) end

-- Set the cursor position in the command line to byte position
-- 		{pos}.  The first position is 1.
-- 		Use |getcmdpos()| to obtain the current position.
-- 		Only works while editing the command line, thus you must use
-- 		|c_CTRL-\_e|, |c_CTRL-R_=| or |c_CTRL-R_CTRL-R| with '='.  For
-- 		|c_CTRL-\_e| and |c_CTRL-R_CTRL-R| with '=' the position is
-- 		set after the command line is set to the expression.  For
-- 		|c_CTRL-R_=| it is set after evaluating the expression but
-- 		before inserting the resulting text.
-- 		When the number is too big the cursor is put at the end of the
-- 		line.  A number smaller than one has undefined results.
-- 		Returns 0 when successful, 1 when not editing the command
-- 		line.
--- @param pos any?
--- @return number
function vim.fn.setcmdpos(pos) end

-- Set the matches for Insert mode completion.
-- 		Can only be used in Insert mode.  You need to use a mapping
-- 		with CTRL-R = (see |i_CTRL-R|).  It does not work after CTRL-O
-- 		or with an expression mapping.
-- 		{startcol} is the byte offset in the line where the completed
-- 		text start.  The text up to the cursor is the original text
-- 		that will be replaced by the matches.  Use col('.') for an
-- 		empty string.  "col('.') - 1" will replace one character by a
-- 		match.
-- 		{matches} must be a |List|.  Each |List| item is one match.
-- 		See |complete-items| for the kind of items that are possible.
-- 		Note that the after calling this function you need to avoid
-- 		inserting anything that would cause completion to stop.
-- 		The match can be selected with CTRL-N and CTRL-P as usual with
-- 		Insert mode completion.  The popup menu will appear if
-- 		specified, see |ins-completion-menu|.
-- 		Example: >
-- 	inoremap <F5> <C-R>=ListMonths()<CR>
--
-- 	func! ListMonths()
-- 	  call complete(col('.'), ['January', 'February', 'March',
-- 		\ 'April', 'May', 'June', 'July', 'August', 'September',
-- 		\ 'October', 'November', 'December'])
-- 	  return ''
-- 	endfunc
-- <		This isn't very useful, but it shows how it works.  Note that
-- 		an empty string is returned to avoid a zero being inserted.
--- @param startcol any?
--- @param matches any?
--- @return none
function vim.fn.complete(startcol, matches) end

-- Stop a timer.  The timer callback will no longer be invoked.
-- 		{timer} is an ID returned by timer_start(), thus it must be a
-- 		Number.  If {timer} does not exist there is no error.
--- @param timer any?
--- @return none
function vim.fn.timer_stop(timer) end

-- Set line {lnum} of the current buffer to {text}.  To insert
-- 		lines use |append()|. To set lines in another buffer use
-- 		|setbufline()|.
--
-- 		{lnum} is used like with |getline()|.
-- 		When {lnum} is just below the last line the {text} will be
-- 		added as a new line.
--
-- 		If this succeeds, 0 is returned.  If this fails (most likely
-- 		because {lnum} is invalid) 1 is returned.
--
-- 		Example: >
-- 			:call setline(5, strftime("%c"))
--
-- <		When {text} is a |List| then line {lnum} and following lines
-- 		will be set to the items in the list.  Example: >
-- 			:call setline(5, ['aaa', 'bbb', 'ccc'])
-- <		This is equivalent to: >
-- 			:for [n, l] in [[5, 'aaa'], [6, 'bbb'], [7, 'ccc']]
-- 			:  call setline(n, l)
-- 			:endfor
--
-- <		Note: The '[ and '] marks are not set.
--- @param lnum any?
--- @param line any?
--- @return number
function vim.fn.setline(lnum, line) end

-- Sort the items in {list} in-place.  Returns {list}.
--
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let sortedlist = sort(copy(mylist))
--
-- <		When {func} is omitted, is empty or zero, then sort() uses the
-- 		string representation of each item to sort on.  Numbers sort
-- 		after Strings, |Lists| after Numbers.  For sorting text in the
-- 		current buffer use |:sort|.
--
-- 		When {func} is given and it is '1' or 'i' then case is
-- 		ignored.
--
-- 		When {func} is given and it is 'n' then all items will be
-- 		sorted numerical (Implementation detail: This uses the
-- 		strtod() function to parse numbers, Strings, Lists, Dicts and
-- 		Funcrefs will be considered as being 0).
--
-- 		When {func} is given and it is 'N' then all items will be
-- 		sorted numerical. This is like 'n' but a string containing
-- 		digits will be used as the number they represent.
--
-- 		When {func} is given and it is 'f' then all items will be
-- 		sorted numerical. All values must be a Number or a Float.
--
-- 		When {func} is a |Funcref| or a function name, this function
-- 		is called to compare items.  The function is invoked with two
-- 		items as argument and must return zero if they are equal, 1 or
-- 		bigger if the first one sorts after the second one, -1 or
-- 		smaller if the first one sorts before the second one.
--
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--
-- 		The sort is stable, items which compare equal (as number or as
-- 		string) will keep their relative position. E.g., when sorting
-- 		on numbers, text strings will sort next to each other, in the
-- 		same order as they were originally.
--
-- 		Also see |uniq()|.
--
-- 		Example: >
-- 			func MyCompare(i1, i2)
-- 			   return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? 1 : -1
-- 			endfunc
-- 			let sortedlist = sort(mylist, "MyCompare")
-- <		A shorter compare version for this specific simple case, which
-- 		ignores overflow: >
-- 			func MyCompare(i1, i2)
-- 			   return a:i1 - a:i2
-- 			endfunc
-- <
--- @param list any?
--- @param func any?
--- @param dict dictionary?
--- @return list
function vim.fn.sort(list, func, dict) end

-- Create or replace or add to the location list for window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero the current window is used.
--
-- 		For a location list window, the displayed location list is
-- 		modified.  For an invalid window number {nr}, -1 is returned.
-- 		Otherwise, same as |setqflist()|.
-- 		Also see |location-list|.
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		only the items listed in {what} are set. Refer to |setqflist()|
-- 		for the list of supported keys in {what}.
--- @param nr any?
--- @param list any?
--- @param action any?
--- @param what any?
--- @return number
function vim.fn.setloclist(nr, list, action, what) end

-- Selects the {nr} match item, as set with a |:match|,
-- 		|:2match| or |:3match| command.
-- 		Return a |List| with two elements:
-- 			The name of the highlight group used
-- 			The pattern used.
-- 		When {nr} is not 1, 2 or 3 returns an empty |List|.
-- 		When there is no match item set returns ['', ''].
-- 		This is useful to save and restore a |:match|.
-- 		Highlighting matches using the |:match| commands are limited
-- 		to three matches. |matchadd()| does not have this limitation.
--- @param nr any?
--- @return list
function vim.fn.matcharg(nr) end

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any?
--- @return number
function vim.fn.setmatches(list) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Uses Python 2 or 3, see |python_x| and 'pyxversion'.
-- 		See also: |pyeval()|, |py3eval()|
--- @param expr any?
--- @return any
function vim.fn.pyxeval(expr) end

-- Set the register {regname} to {value}.
-- 		{value} may be any value returned by |getreg()|, including
-- 		a |List|.
-- 		If {options} contains "a" or {regname} is upper case,
-- 		then the value is appended.
-- 		{options} can also contain a register type specification:
-- 		    "c" or "v"	      |charwise| mode
-- 		    "l" or "V"	      |linewise| mode
-- 		    "b" or "<CTRL-V>" |blockwise-visual| mode
-- 		If a number immediately follows "b" or "<CTRL-V>" then this is
-- 		used as the width of the selection - if it is not specified
-- 		then the width of the block is set to the number of characters
-- 		in the longest line (counting a <Tab> as 1 character).
-- 		If {options} contains "u" or '"', then the unnamed register is
-- 		set to point to register {regname}.
--
-- 		If {options} contains no register settings, then the default
-- 		is to use character mode unless {value} ends in a <NL> for
-- 		string {value} and linewise mode for list {value}. Blockwise
-- 		mode is never selected automatically.
-- 		Returns zero for success, non-zero for failure.
--
-- 							*E883*
-- 		Note: you may not use |List| containing more than one item to
-- 		      set search and expression registers. Lists containing no
-- 		      items act like empty strings.
--
-- 		Examples: >
-- 			:call setreg(v:register, @*)
-- 			:call setreg('*', @%, 'ac')
-- 			:call setreg('a', "1\n2\n3", 'b5')
--
-- <		This example shows using the functions to save and restore a
-- 		register: >
-- 			:let var_a = getreg('a', 1, 1)
-- 			:let var_amode = getregtype('a')
-- 			    ....
-- 			:call setreg('a', var_a, var_amode)
-- <		Note: you may not reliably restore register value
-- 		without using the third argument to |getreg()| as without it
-- 		newlines are represented as newlines AND Nul bytes are
-- 		represented as newlines as well, see |NL-used-for-Nul|.
--
-- 		You can also change the type of a register by appending
-- 		nothing: >
-- 			:call setreg('a', '', 'al')
--- @param n any?
--- @param v any?
--- @param opt any?
--- @return number
function vim.fn.setreg(n, v, opt) end

-- Return the name of the undo file that would be used for a file
-- 		with name {name} when writing.  This uses the 'undodir'
-- 		option, finding directories that exist.  It does not check if
-- 		the undo file exists.
-- 		{name} is always expanded to the full path, since that is what
-- 		is used internally.
-- 		If {name} is empty undofile() returns an empty string, since a
-- 		buffer without a file name will not write an undo file.
-- 		Useful in combination with |:wundo| and |:rundo|.
-- 		When compiled without the |+persistent_undo| option this always
-- 		returns an empty string.
--- @param name any?
--- @return string
function vim.fn.undofile(name) end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
--- @param nr any?
--- @param varname any?
--- @param val any?
--- @return set
function vim.fn.settabvar(nr, varname, val) end

-- Get the title of terminal {buf}. This is the title that the
-- 		job in the terminal has set.
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		string is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_gettitle()
--- @param buf any?
--- @return string
function vim.fn.term_gettitle(buf) end

-- Set option or local variable {varname} in window {winnr} to
-- 		{val}.
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |setwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global or local buffer option, but it
-- 		doesn't work for a global or local buffer variable.
-- 		For a local buffer option the global value is unchanged.
-- 		Note that the variable name without "w:" must be used.
-- 		Examples: >
-- 			:call settabwinvar(1, 1, "&list", 0)
-- 			:call settabwinvar(3, 2, "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @param tabnr any?
--- @param winnr any?
--- @param varname any?
--- @param val any?
--- @return set
function vim.fn.settabwinvar(tabnr, winnr, varname, val) end

-- Confirm() offers the user a dialog, from which a choice can be
-- 		made.  It returns the number of the choice.  For the first
-- 		choice this is 1.
--
-- 		{msg} is displayed in a dialog with {choices} as the
-- 		alternatives.  When {choices} is missing or empty, "&OK" is
-- 		used (and translated).
-- 		{msg} is a String, use '\n' to include a newline.  Only on
-- 		some systems the string is wrapped when it doesn't fit.
--
-- 		{choices} is a String, with the individual choices separated
-- 		by '\n', e.g. >
-- 			confirm("Save changes?", "&Yes\n&No\n&Cancel")
-- <		The letter after the '&' is the shortcut key for that choice.
-- 		Thus you can type 'c' to select "Cancel".  The shortcut does
-- 		not need to be the first letter: >
-- 			confirm("file has been modified", "&Save\nSave &All")
-- <		For the console, the first letter of each choice is used as
-- 		the default shortcut key.
--
-- 		The optional {default} argument is the number of the choice
-- 		that is made if the user hits <CR>.  Use 1 to make the first
-- 		choice the default one.  Use 0 to not set a default.  If
-- 		{default} is omitted, 1 is used.
--
-- 		The optional {type} argument gives the type of dialog.  This
-- 		is only used for the icon of the Win32 GUI.  It can be one of
-- 		these values: "Error", "Question", "Info", "Warning" or
-- 		"Generic".  Only the first character is relevant.
-- 		When {type} is omitted, "Generic" is used.
--
-- 		If the user aborts the dialog by pressing <Esc>, CTRL-C,
-- 		or another valid interrupt key, confirm() returns 0.
--
-- 		An example: >
--    :let choice = confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2)
--    :if choice == 0
--    :	echo "make up your mind!"
--    :elseif choice == 3
--    :	echo "tasteful"
--    :else
--    :	echo "I prefer bananas myself."
--    :endif
-- <		In a GUI dialog, buttons are used.  The layout of the buttons
-- 		depends on the 'v' flag in 'guioptions'.  If it is included,
-- 		the buttons are always put vertically.  Otherwise,  confirm()
-- 		tries to put the buttons in one horizontal line.  If they
-- 		don't fit, a vertical layout is used anyway.  For some systems
-- 		the horizontal layout is always used.
--- @param msg any?
--- @param choices any?
--- @param default any?
--- @param type any?
--- @return number
function vim.fn.confirm(msg, choices, default, type) end

