--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- When v:exception does not contain the string {error} an error
-- 		message is added to |v:errors|.  Also see |assert-return|.
-- 		This can be used to assert that a command throws an exception.
-- 		Using the error number, followed by a colon, avoids problems
-- 		with translations: >
-- 			try
-- 			  commandthatfails
-- 			  call assert_false(1, 'command should have failed')
-- 			catch
-- 			  call assert_exception('E492:')
-- 			endtry
--- @param error any?
--- @param msg any?
--- @return number
function vim.fn.assert_exception(error, msg) end

-- Stop |job-id| {id} by sending SIGTERM to the job process. If
-- 		the process does not terminate after a timeout then SIGKILL
-- 		will be sent. When the job terminates its |on_exit| handler
-- 		(if any) will be invoked.
-- 		See |job-control|.
--
-- 		Returns 1 for valid job id, 0 for invalid id, including jobs have
-- 		exited or stopped.
--- @param id any?
--- @return number
function vim.fn.jobstop(id) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce an error.  Also see |assert-return|.
-- 		When {error} is given it must match in |v:errmsg|.
-- 		Note that beeping is not considered an error, and some failing
-- 		commands only beep.  Use |assert_beeps()| for those.
--- @param cmd any?
--- @param error any?
--- @return number
function vim.fn.assert_fails(cmd, error) end

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @param actual any?
--- @param msg any?
--- @return number
function vim.fn.assert_false(actual, msg) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @param lower any?
--- @param upper any?
--- @param actual any?
--- @param msg any?
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

-- Convert {expr} into a JSON string.  Accepts
-- 		|msgpack-special-dict| as the input.  Will not convert
-- 		|Funcref|s, mappings with non-string keys (can be created as
-- 		|msgpack-special-dict|), values with self-referencing
-- 		containers, strings which contain non-UTF-8 characters,
-- 		pseudo-UTF-8 strings which contain codepoints reserved for
-- 		surrogate pairs (such strings are not valid UTF-8 strings).
-- 		Non-printable characters are converted into "\u1234" escapes
-- 		or special escapes like "\t", other are dumped as-is.
--- @param expr any?
--- @return string
function vim.fn.json_encode(expr) end

-- Return the {options} for popup {id} in a Dict.
-- 		A zero value means the option was not set.  For "zindex" the
-- 		default value is returned, not zero.
--
-- 		The "moved" entry is a list with line number, minimum and
-- 		maximum column, [0, 0, 0] when not set.
--
-- 		The "mousemoved" entry is a list with screen row, minimum and
-- 		maximum screen column, [0, 0, 0] when not set.
--
-- 		"firstline" is the property set on the popup, unlike the
-- 		"firstline" obtained with |popup_getpos()| which is the actual
-- 		buffer line at the top of the popup window.
--
-- 		"border" and "padding" are not included when all values are
-- 		zero.  When all values are one then an empty list is included.
--
-- 		"borderhighlight" is not included when all values are empty.
-- 		"scrollbarhighlight" and "thumbhighlight" are only included
-- 		when set.
--
-- 		"tabpage" will be -1 for a global popup, zero for a popup on
-- 		the current tabpage and a positive number for a popup on
-- 		another tabpage.
--
-- 		"textprop", "textpropid" and "textpropwin" are only present
-- 		when "textprop" was set.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getoptions()
--- @param id any?
--- @return dict
function vim.fn.popup_getoptions(id) end

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @param exp any?
--- @param act any?
--- @param msg any?
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @param pat any?
--- @param text any?
--- @param msg any?
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @param msg any?
--- @return number
function vim.fn.assert_report(msg) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @param actual any?
--- @param msg any?
--- @return number
function vim.fn.assert_true(actual, msg) end

-- Show the {what} for 3 seconds at the top of the Vim window.
-- 		This works like: >
-- 			call popup_create({what}, #{
-- 				\ line: 1,
-- 				\ col: 10,
-- 				\ minwidth: 20,
-- 				\ time: 3000,
-- 				\ tabpage: -1,
-- 				\ zindex: 300,
-- 				\ drag: 1,
-- 				\ highlight: 'WarningMsg',
-- 				\ border: [],
-- 				\ close: 'click',
-- 				\ padding: [0,1,0,1],
-- 				\ })
-- <		The PopupNotification highlight group is used instead of
-- 		WarningMsg if it is defined.
--
-- 		Without the |+timers| feature the popup will not disappear
-- 		automatically, the user has to click in it.
--
-- 		The position will be adjusted to avoid overlap with other
-- 		notifications.
-- 		Use {options} to change the properties.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_notification({})
--- @param what any?
--- @param options any?
--- @return number
function vim.fn.popup_notification(what, options) end

-- Execute Lua code. Parameters (if any) are available as `...`
--                 inside the chunk. The chunk can return a value.
--
--                 Only statements are executed. To evaluate an expression,
--                 prefix it with `return` : return my_function(...)
--
--                 Parameters: ~
--                     {code}  Lua code to execute
--                     {args}  Arguments to the code
--
--                 Return: ~
--                     Return value of Lua code if present or NIL.
--- @param code any?
--- @param args any?
--- @return any
function vim.fn.nvim_exec_lua(code, args) end

-- Return the current time, measured as seconds since 1st Jan
-- 		1970.  See also |strftime()| and |getftime()|.
--- @return number
function vim.fn.localtime() end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists.
-- 		If the {expr} argument is a number, buffer numbers are used.
-- 		Number zero is the alternate buffer for the current window.
--
-- 		If the {expr} argument is a string it must match a buffer name
-- 		exactly.  The name can be:
-- 		- Relative to the current directory.
-- 		- A full path.
-- 		- The name of a buffer with 'buftype' set to "nofile".
-- 		- A URL name.
-- 		Unlisted buffers will be found.
-- 		Note that help files are listed by their short name in the
-- 		output of |:buffers|, but bufexists() requires using their
-- 		long name to be able to find them.
-- 		bufexists() may report a buffer exists, but to use the name
-- 		with a |:buffer| command you may need to use |expand()|.  Esp
-- 		for MS-Windows 8.3 names in the form "c:\DOCUME~1"
-- 		Use "bufexists(0)" to test for the existence of an alternate
-- 		file name.
--- @param expr any?
--- @return number
function vim.fn.bufexists(expr) end

-- Attach a text property at position {lnum}, {col}.  {col} is
-- 		counted in bytes, use one for the first column.
-- 		If {lnum} is invalid an error is given. *E966*
-- 		If {col} is invalid an error is given. *E964*
--
-- 		{props} is a dictionary with these fields:
-- 		   length	length of text in bytes, can only be used
-- 				for a property that does not continue in
-- 				another line; can be zero
-- 		   end_lnum	line number for the end of text
-- 		   end_col	column just after the text; not used when
-- 				"length" is present; when {col} and "end_col"
-- 				are equal, and "end_lnum" is omitted or equal
-- 				to {lnum}, this is a zero-width text property
-- 		   bufnr	buffer to add the property to; when omitted
-- 				the current buffer is used
-- 		   id		user defined ID for the property; when omitted
-- 				zero is used
-- 		   type		name of the text property type
-- 		All fields except "type" are optional.
--
-- 		It is an error when both "length" and "end_lnum" or "end_col"
-- 		are given.  Either use "length" or "end_col" for a property
-- 		within one line, or use "end_lnum" and "end_col" for a
-- 		property that spans more than one line.
-- 		When neither "length" nor "end_col" are given the property
-- 		will be zero-width.  That means it will not be highlighted but
-- 		will move with the text, as a kind of mark.
-- 		The property can end exactly at the last character of the
-- 		text, or just after it.  In the last case, if text is appended
-- 		to the line, the text property size will increase, also when
-- 		the property type does not have "end_incl" set.
--
-- 		"type" will first be looked up in the buffer the property is
-- 		added to. When not found, the global property types are used.
-- 		If not found an error is given.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_add(col, props)
--- @param lnum any?
--- @param col any?
--- @param props any?
--- @return none
function vim.fn.prop_add(lnum, col, props) end

-- Remove all text properties from line {lnum}.
-- 		When {lnum-end} is given, remove all text properties from line
-- 		{lnum} to {lnum-end} (inclusive).
--
-- 		When {props} contains a "bufnr" item use this buffer,
-- 		otherwise use the current buffer.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_clear()
-- <
--- @param lnum any?
--- @param lnum_end any?
--- @param props any?
--- @return none
function vim.fn.prop_clear(lnum, lnum_end, props) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is loaded (shown in a window or hidden).
-- 		The {expr} argument is used like with |bufexists()|.
--- @param expr any?
--- @return number
function vim.fn.bufloaded(expr) end

-- When {dict} is omitted or zero: Return the rhs of mapping
-- 		{name} in mode {mode}.  The returned String has special
-- 		characters translated like in the output of the ":map" command
-- 		listing.
--
-- 		When there is no mapping for {name}, an empty String is
-- 		returned.  When the mapping for {name} is empty, then "<Nop>"
-- 		is returned.
--
-- 		The {name} can have special key names, like in the ":map"
-- 		command.
--
-- 		{mode} can be one of these strings:
-- 			"n"	Normal
-- 			"v"	Visual (including Select)
-- 			"o"	Operator-pending
-- 			"i"	Insert
-- 			"c"	Cmd-line
-- 			"s"	Select
-- 			"x"	Visual
-- 			"l"	langmap |language-mapping|
-- 			"t"	Terminal
-- 			""	Normal, Visual and Operator-pending
-- 		When {mode} is omitted, the modes for "" are used.
--
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.
--
-- 		When {dict} is there and it is |TRUE| return a dictionary
-- 		containing all the information of the mapping with the
-- 		following items:
-- 		  "lhs"	     The {lhs} of the mapping.
-- 		  "rhs"	     The {rhs} of the mapping as typed.
-- 		  "silent"   1 for a |:map-silent| mapping, else 0.
-- 		  "noremap"  1 if the {rhs} of the mapping is not remappable.
-- 		  "expr"     1 for an expression mapping (|:map-<expr>|).
-- 		  "buffer"   1 for a buffer local mapping (|:map-local|).
-- 		  "mode"     Modes for which the mapping is defined. In
-- 			     addition to the modes mentioned above, these
-- 			     characters will be used:
-- 			     " "     Normal, Visual and Operator-pending
-- 			     "!"     Insert and Commandline mode
-- 				     (|mapmode-ic|)
-- 		  "sid"	     The script local ID, used for <sid> mappings
-- 			     (|<SID>|).
-- 		  "lnum"     The line number in "sid", zero if unknown.
-- 		  "nowait"   Do not wait for other, longer mappings.
-- 			     (|:map-<nowait>|).
--
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to map a key even when it's already
-- 		mapped, and have it do the original mapping too.  Sketch: >
-- 			exe 'nnoremap <Tab> ==' . maparg('<Tab>', 'n')
--- @param name any?
--- @param mode any?
--- @param abbr any?
--- @param dict dictionary?
--- @return string
function vim.fn.maparg(name, mode, abbr, dict) end

-- Check if there is a mapping that matches with {name} in mode
-- 		{mode}.  See |maparg()| for {mode} and special names in
-- 		{name}.
-- 		When {abbr} is there and it is non-zero use abbreviations
-- 		instead of mappings.
-- 		A match happens with a mapping that starts with {name} and
-- 		with a mapping which is equal to the start of {name}.
--
-- 			matches mapping "a"	"ab"	"abc" ~
-- 		   mapcheck("a")	yes	yes	 yes
-- 		   mapcheck("abc")	yes	yes	 yes
-- 		   mapcheck("ax")	yes	no	 no
-- 		   mapcheck("b")	no	no	 no
--
-- 		The difference with maparg() is that mapcheck() finds a
-- 		mapping that matches with {name}, while maparg() only finds a
-- 		mapping for {name} exactly.
-- 		When there is no mapping that starts with {name}, an empty
-- 		String is returned.  If there is one, the RHS of that mapping
-- 		is returned.  If there are several mappings that start with
-- 		{name}, the RHS of one of them is returned.  This will be
-- 		"<Nop>" if the RHS is empty.
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to check if a mapping can be added
-- 		without being ambiguous.  Example: >
-- 	:if mapcheck("_vv") == ""
-- 	:   map _vv :set guifont=7x13<CR>
-- 	:endif
-- <		This avoids adding the "_vv" mapping when there already is a
-- 		mapping for "_v" or for "_vvv".
--- @param name any?
--- @param mode any?
--- @param abbr any?
--- @return string
function vim.fn.mapcheck(name, mode, abbr) end

-- The result is a Number, which is the |window-ID| of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinid(1))
-- <
-- 		Only deals with the current tab page.
--- @param expr any?
--- @return number
function vim.fn.bufwinid(expr) end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @param lnum any?
--- @return number
function vim.fn.cindent(lnum) end

-- Change properties of an existing text property type.  If a
-- 		property with this name does not exist an error is given.
-- 		The {props} argument is just like |prop_type_add()|.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_change(props)
--- @param name any?
--- @param props any?
--- @return none
function vim.fn.prop_type_change(name, props) end

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @param byte any?
--- @return number
function vim.fn.byte2line(byte) end

-- Remove the text property type {name}.  When text properties
-- 		using the type {name} are still in place, they will not have
-- 		an effect and can no longer be removed by name.
--
-- 		{props} can contain a "bufnr" item.  When it is given, delete
-- 		a property type from this buffer instead of from the global
-- 		property types.
--
-- 		When text property type {name} is not found there is no error.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_delete()
--- @param name any?
--- @param props any?
--- @return none
function vim.fn.prop_type_delete(name, props) end

-- Return byte index of the {nr}'th character in the string
-- 		{expr}.  Use zero for the first character, it returns zero.
-- 		This function is only useful when there are multibyte
-- 		characters, otherwise the returned value is equal to {nr}.
-- 		Composing characters are not counted separately, their byte
-- 		length is added to the preceding base character.  See
-- 		|byteidxcomp()| below for counting composing characters
-- 		separately.
-- 		Example : >
-- 			echo matchstr(str, ".", byteidx(str, 3))
-- <		will display the fourth character.  Another way to do the
-- 		same: >
-- 			let s = strpart(str, byteidx(str, 3))
-- 			echo strpart(s, 0, byteidx(s, 1))
-- <		Also see |strgetchar()| and |strcharpart()|.
--
-- 		If there are less than {nr} characters -1 is returned.
-- 		If there are exactly {nr} characters the length of the string
-- 		in bytes is returned.
--- @param expr any?
--- @param nr any?
--- @return number
function vim.fn.byteidx(expr, nr) end

-- Returns the properties of property type {name}.  This is a
-- 		dictionary with the same fields as was given to
-- 		prop_type_add().
-- 		When the property type {name} does not exist, an empty
-- 		dictionary is returned.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_get()
--- @param name any?
--- @param props any?
--- @return dict
function vim.fn.prop_type_get(name, props) end

-- Like byteidx(), except that a composing character is counted
-- 		as a separate character.  Example: >
-- 			let s = 'e' . nr2char(0x301)
-- 			echo byteidx(s, 1)
-- 			echo byteidxcomp(s, 1)
-- 			echo byteidxcomp(s, 2)
-- <		The first and third echo result in 3 ('e' plus composing
-- 		character is 3 bytes), the second echo results in 1 ('e' is
-- 		one byte).
--- @param expr any?
--- @param nr any?
--- @return number
function vim.fn.byteidxcomp(expr, nr) end

-- Returns a list with all property type names.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--- @param props any?
--- @return list
function vim.fn.prop_type_list(props) end

-- Waits until {condition} evaluates to |TRUE|, where {condition}
-- 		is a |Funcref| or |string| containing an expression.
--
-- 		{timeout} is the maximum waiting time in milliseconds, -1
-- 		means forever.
--
-- 		Condition is evaluated on user events, internal events, and
-- 		every {interval} milliseconds (default: 200).
--
-- 		Returns a status integer:
-- 			0 if the condition was satisfied before timeout
-- 			-1 if the timeout was exceeded
-- 			-2 if the function was interrupted (by |CTRL-C|)
-- 			-3 if an error occurred
--- @param timeout any?
--- @param condition any?
--- @param interval any?
--- @return number
function vim.fn.wait(timeout, condition, interval) end

-- Same as |matchstr()|, but return the matched string, the start
-- 		position and the end position of the match.  Example: >
-- 			:echo matchstrpos("testing", "ing")
-- <		results in ["ing", 4, 7].
-- 		When there is no match ["", -1, -1] is returned.
-- 		The {start}, if given, has the same meaning as for |match()|. >
-- 			:echo matchstrpos("testing", "ing", 2)
-- <		results in ["ing", 4, 7]. >
-- 			:echo matchstrpos("testing", "ing", 5)
-- <		result is ["", -1, -1].
-- 		When {expr} is a |List| then the matching item, the index
-- 		of first item where {pat} matches, the start position and the
-- 		end position of the match are returned. >
-- 			:echo matchstrpos([1, '__x'], '\a')
-- <		result is ["x", 1, 2, 3].
-- 		The type isn't changed, it's not necessarily a String.
--- @param expr any?
--- @param pat any?
--- @param start any?
--- @param count any?
--- @return list
function vim.fn.matchstrpos(expr, pat, start, count) end

-- Send data to channel {id}. For a job, it writes it to the
-- 		stdin of the process. For the stdio channel |channel-stdio|,
-- 		it writes to Nvim's stdout.  Returns the number of bytes
-- 		written if the write succeeded, 0 otherwise.
-- 		See |channel-bytes| for more information.
--
-- 		{data} may be a string, string convertible, or a list.  If
-- 		{data} is a list, the items will be joined by newlines; any
-- 		newlines in an item will be sent as NUL. To send a final
-- 		newline, include a final empty string. Example: >
-- 			:call chansend(id, ["abc", "123\n456", ""])
-- < 		will send "abc<NL>123<NUL>456<NL>".
--
-- 		chansend() writes raw data, not RPC messages.  If the channel
-- 		was created with `"rpc":v:true` then the channel expects RPC
-- 		messages, use |rpcnotify()| and |rpcrequest()| instead.
--- @param id any?
--- @param data any?
--- @return number
function vim.fn.chansend(id, data) end

-- The result is a String that contains the base character and
-- 		any composing characters at position [row, col] on the screen.
-- 		This is like |screenchars()| but returning a String with the
-- 		characters.
-- 		This is mainly to be used for testing.
-- 		Returns an empty String when row or col is out of range.
--
-- 		Can also be used as a |method|: >
-- 			GetRow()->screenstring(col)
--- @param row any?
--- @param col any?
--- @return string
function vim.fn.screenstring(row, col) end

--- @param list any?
--- @return list
function vim.fn.sign_placelist(list) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- Play a sound identified by {name}.  Which event names are
-- 		supported depends on the system.  Often the XDG sound names
-- 		are used.  On Ubuntu they may be found in
-- 		/usr/share/sounds/freedesktop/stereo.  Example: >
-- 			call sound_playevent('bell')
-- <		On MS-Windows, {name} can be SystemAsterisk, SystemDefault,
-- 		SystemExclamation, SystemExit, SystemHand, SystemQuestion,
-- 		SystemStart, SystemWelcome, etc.
--
-- 		When {callback} is specified it is invoked when the sound is
-- 		finished.  The first argument is the sound ID, the second
-- 		argument is the status:
-- 			0	sound was played to the end
-- 			1	sound was interrupted
-- 			2	error occurred after sound started
-- 		Example: >
-- 		   func Callback(id, status)
-- 		     echomsg "sound " .. a:id .. " finished with " .. a:status
-- 		   endfunc
-- 		   call sound_playevent('bell', 'Callback')
--
-- <		MS-Windows: {callback} doesn't work for this function.
--
-- 		Returns the sound ID, which can be passed to `sound_stop()`.
-- 		Returns zero if the sound could not be played.
--
-- 		Can also be used as a |method|: >
-- 			GetSoundName()->sound_playevent()
--
-- <		{only available when compiled with the |+sound| feature}
--- @param name any?
--- @param callback any?
--- @return number
function vim.fn.sound_playevent(name, callback) end

-- Return a string with a single character, which has the number
-- 		value {expr}.  Examples: >
-- 			nr2char(64)		returns "@"
-- 			nr2char(32)		returns " "
-- <		Example for "utf-8": >
-- 			nr2char(300)		returns I with bow character
-- <		UTF-8 encoding is always used, {utf8} option has no effect,
-- 		and exists only for backwards-compatibility.
-- 		Note that a NUL character in the file is specified with
-- 		nr2char(10), because NULs are represented with newline
-- 		characters.  nr2char(0) is a real NUL and terminates the
-- 		string, thus results in an empty string.
--
-- nvim_...({...})					*E5555* *nvim_...()* *eval-api*
-- 		Call nvim |api| functions. The type checking of arguments will
-- 		be stricter than for most other builtins. For instance,
-- 		if Integer is expected, a |Number| must be passed in, a
-- 		|String| will not be autoconverted.
-- 		Buffer numbers, as returned by |bufnr()| could be used as
-- 		first argument to nvim_buf_... functions.  All functions
-- 		expecting an object (buffer, window or tabpage) can
-- 		also take the numerical value 0 to indicate the current
-- 		(focused) object.
--- @param expr any?
--- @param utf8 any?
--- @return string
function vim.fn.nr2char(expr, utf8) end

-- Like `sound_playevent()` but play sound file {path}.  {path}
-- 		must be a full path.  On Ubuntu you may find files to play
-- 		with this command: >
-- 		    :!find /usr/share/sounds -type f | grep -v index.theme
--
-- <		Can also be used as a |method|: >
-- 			GetSoundPath()->sound_playfile()
--
-- <		{only available when compiled with the |+sound| feature}
--- @param path any?
--- @param callback any?
--- @return number
function vim.fn.sound_playfile(path, callback) end

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

-- Stop playing sound {id}.  {id} must be previously returned by
-- 		`sound_playevent()` or `sound_playfile()`.
--
-- 		On MS-Windows, this does not work for event sound started by
-- 		`sound_playevent()`. To stop event sounds, use `sound_clear()`.
--
-- 		Can also be used as a |method|: >
-- 			soundid->sound_stop()
--
-- <		{only available when compiled with the |+sound| feature}
--- @param id any?
--- @return none
function vim.fn.sound_stop(id) end

-- The result is a Number, which is a unix timestamp representing
-- 		the date and time in {timestring}, which is expected to match
-- 		the format specified in {format}.
--
-- 		The accepted {format} depends on your system, thus this is not
-- 		portable!  See the manual page of the C function strptime()
-- 		for the format.  Especially avoid "%c".  The value of $TZ also
-- 		matters.
--
-- 		If the {timestring} cannot be parsed with {format} zero is
-- 		returned.  If you do not know the format of {timestring} you
-- 		can try different {format} values until you get a non-zero
-- 		result.
--
-- 		See also |strftime()|.
-- 		Examples: >
-- 		  :echo strptime("%Y %b %d %X", "1997 Apr 27 11:49:23")
-- <		  862156163 >
-- 		  :echo strftime("%c", strptime("%y%m%d %T", "970427 11:53:55"))
-- <		  Sun Apr 27 11:53:55 1997 >
-- 		  :echo strftime("%c", strptime("%Y%m%d%H%M%S", "19970427115355") + 3600)
-- <		  Sun Apr 27 12:53:55 1997
--
-- 		Not available on all systems.  To check use: >
-- 			:if exists("*strptime")
--- @param format any?
--- @param timestring any?
--- @return number
function vim.fn.strptime(format, timestring) end

-- Open a new window displaying the difference between the two
-- 		files.  The files must have been created with
-- 		|term_dumpwrite()|.
-- 		Returns the buffer number or zero when the diff fails.
-- 		Also see |terminal-diff|.
-- 		NOTE: this does not work with double-width characters yet.
--
-- 		The top part of the buffer contains the contents of the first
-- 		file, the bottom part of the buffer contains the contents of
-- 		the second file.  The middle part shows the differences.
-- 		The parts are separated by a line of equals.
--
-- 		If the {options} argument is present, it must be a Dict with
-- 		these possible members:
-- 		   "term_name"	     name to use for the buffer name, instead
-- 				     of the first file name.
-- 		   "term_rows"	     vertical size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "term_cols"	     horizontal size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "vertical"	     split the window vertically
-- 		   "curwin"	     use the current window, do not split the
-- 				     window; fails if the current buffer
-- 				     cannot be |abandon|ed
-- 		   "bufnr"	     do not create a new buffer, use the
-- 				     existing buffer "bufnr".  This buffer
-- 				     must have been previously created with
-- 				     term_dumpdiff() or term_dumpload() and
-- 				     visible in a window.
-- 		   "norestore"	     do not add the terminal window to a
-- 				     session file
--
-- 		Each character in the middle part indicates a difference. If
-- 		there are multiple differences only the first in this list is
-- 		used:
-- 			X	different character
-- 			w	different width
-- 			f	different foreground color
-- 			b	different background color
-- 			a	different attribute
-- 			+	missing position in first file
-- 			-	missing position in second file
--
-- 		Using the "s" key the top and bottom parts are swapped.  This
-- 		makes it easy to spot a difference.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpdiff(otherfile)
-- <
--- @param filename any?
--- @param filename any?
--- @param options any?
--- @return number
function vim.fn.term_dumpdiff(filename, filename, options) end

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
--- @param event any?
--- @return any
function vim.fn.nvim_subscribe(event) end

-- Open a new window displaying the contents of {filename}
-- 		The file must have been created with |term_dumpwrite()|.
-- 		Returns the buffer number or zero when it fails.
-- 		Also see |terminal-diff|.
--
-- 		For {options} see |term_dumpdiff()|.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpload()
-- <
--- @param filename any?
--- @param options any?
--- @return number
function vim.fn.term_dumpload(filename, options) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
--- @param event any?
--- @return any
function vim.fn.nvim_unsubscribe(event) end

-- Pops and restores the |context| at the top of the
-- 		|context-stack|.
--- @return none
function vim.fn.ctxpop() end

-- Set prompt for buffer {buf} to {text}.  You most likely want
-- 		{text} to end in a space.
-- 		The result is only visible if {buf} has 'buftype' set to
-- 		"prompt".  Example: >
-- 			call prompt_setprompt(bufnr(''), 'command: ')
--- @param buf any?
--- @param text any?
--- @return none
function vim.fn.prompt_setprompt(buf, text) end

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @param buf any?
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- If the popup menu (see |ins-completion-menu|) is not visible,
--  		returns an empty |Dictionary|, otherwise, returns a
--  		|Dictionary| with the following keys:
--  			height		nr of items visible
--  			width		screen cells
--  			row		top screen row (0 first row)
--  			col		leftmost screen column (0 first col)
--  			size		total nr of items
--  			scrollbar	|TRUE| if visible
--
--   		The values are the same as in |v:event| during |CompleteChanged|.
--- @return dict
function vim.fn.pum_getpos() end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @param context any?
--- @param index any?
--- @return none
function vim.fn.ctxset(context, index) end

-- Returns non-zero when the popup menu is visible, zero
-- 		otherwise.  See |ins-completion-menu|.
-- 		This can be used to avoid some things that would remove the
-- 		popup menu.
--- @return number
function vim.fn.pumvisible() end

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are (strings are
-- 		copied though).
-- 		Lists are represented as Vim |List| type.
-- 		Dictionaries are represented as Vim |Dictionary| type,
-- 		non-string keys result in error.
--- @param expr any?
--- @return any
function vim.fn.pyeval(expr) end

-- Get the cursor position of terminal {buf}. Returns a list with
-- 		two numbers and a dictionary: [row, col, dict].
--
-- 		"row" and "col" are one based, the first screen cell is row
-- 		1, column 1.  This is the cursor position of the terminal
-- 		itself, not of the Vim window.
--
-- 		"dict" can have these members:
-- 		   "visible"	one when the cursor is visible, zero when it
-- 				is hidden.
-- 		   "blink"	one when the cursor is blinking, zero when it
-- 				is not blinking.
-- 		   "shape"	1 for a block cursor, 2 for underline and 3
-- 				for a vertical bar.
-- 		   "color"	color of the cursor, e.g. "green"
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getcursor()
--- @param buf any?
--- @return list
function vim.fn.term_getcursor(buf) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are (strings are
-- 		copied though, Unicode strings are additionally converted to
-- 		UTF-8).
-- 		Lists are represented as Vim |List| type.
-- 		Dictionaries are represented as Vim |Dictionary| type with
-- 		keys converted to strings.
--- @param expr any?
--- @return any
function vim.fn.py3eval(expr) end

-- Deactivates buffer-update events on the channel.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--
--                 Return: ~
--                     False if detach failed (because the buffer isn't loaded);
--                     otherwise True.
--
--                 See also: ~
--                     |nvim_buf_attach()|
--                     |api-lua-detach| for detaching Lua callbacks
--- @param buffer any?
--- @return any
function vim.fn.nvim_buf_detach(buffer) end

-- Return a |List| with spelling suggestions to replace {word}.
-- 		When {max} is given up to this number of suggestions are
-- 		returned.  Otherwise up to 25 suggestions are returned.
--
-- 		When the {capital} argument is given and it's non-zero only
-- 		suggestions with a leading capital will be given.  Use this
-- 		after a match with 'spellcapcheck'.
--
-- 		{word} can be a badly spelled word followed by other text.
-- 		This allows for joining two words that were split.  The
-- 		suggestions also include the following text, thus you can
-- 		replace a line.
--
-- 		{word} may also be a good word.  Similar words will then be
-- 		returned.  {word} itself is not included in the suggestions,
-- 		although it may appear capitalized.
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the values of 'spelllang' and
-- 		'spellsuggest' are used.
--- @param word any?
--- @param max any?
--- @param capital any?
--- @return list
function vim.fn.spellsuggest(word, max, capital) end

-- Without {flags} or with {flags} empty: Deletes the file by the
-- 		name {fname}.  This also works when {fname} is a symbolic link.
-- 		A symbolic link itself is deleted, not what it points to.
--
-- 		When {flags} is "d": Deletes the directory by the name
-- 		{fname}.  This fails when directory {fname} is not empty.
--
-- 		When {flags} is "rf": Deletes the directory by the name
-- 		{fname} and everything in it, recursively.  BE CAREFUL!
-- 		Note: on MS-Windows it is not possible to delete a directory
-- 		that is being used.
--
-- 		The result is a Number, which is 0 if the delete operation was
-- 		successful and -1 when the deletion failed or partly failed.
--- @param fname any?
--- @param flags any?
--- @return number
function vim.fn.delete(fname, flags) end

-- Returns the single letter name of the register being executed.
-- 		Returns an empty string when no register is being executed.
-- 		See |@|.
--- @return string
function vim.fn.reg_executing() end

-- Adds a watcher to a dictionary. A dictionary watcher is
-- 		identified by three components:
--
-- 		- A dictionary({dict});
-- 		- A key pattern({pattern}).
-- 		- A function({callback}).
--
-- 		After this is called, every change on {dict} and on keys
-- 		matching {pattern} will result in {callback} being invoked.
--
-- 		For example, to watch all global variables: >
-- 			silent! call dictwatcherdel(g:, '*', 'OnDictChanged')
-- 			function! OnDictChanged(d,k,z)
-- 			  echomsg string(a:k) string(a:z)
-- 			endfunction
-- 			call dictwatcheradd(g:, '*', 'OnDictChanged')
-- <
-- 		For now {pattern} only accepts very simple patterns that can
-- 		contain a '*' at the end of the string, in which case it will
-- 		match every key that begins with the substring before the '*'.
-- 		That means if '*' is not the last character of {pattern}, only
-- 		keys that are exactly equal as {pattern} will be matched.
--
-- 		The {callback} receives three arguments:
--
-- 		- The dictionary being watched.
-- 		- The key which changed.
-- 		- A dictionary containing the new and old values for the key.
--
-- 		The type of change can be determined by examining the keys
-- 		present on the third argument:
--
-- 		- If contains both `old` and `new`, the key was updated.
-- 		- If it contains only `new`, the key was added.
-- 		- If it contains only `old`, the key was deleted.
--
-- 		This function can be used by plugins to implement options with
-- 		validation and parsing logic.
--- @param dict dictionary?
--- @param pattern any?
--- @param callback any?
--- @return start
function vim.fn.dictwatcheradd(dict, pattern, callback) end

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary?
--- @param pattern any?
--- @param callback any?
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

-- Return a String that represents the time value of {time}.
-- 		This is the number of seconds, a dot and the number of
-- 		microseconds.  Example: >
-- 			let start = reltime()
-- 			call MyFunction()
-- 			echo reltimestr(reltime(start))
-- <		Note that overhead for the commands will be added to the time.
-- 		Leading spaces are used to make the string align nicely.  You
-- 		can use split() to remove it. >
-- 			echo split(reltimestr(reltime(start)))[0]
-- <		Also see |profiling|.
--- @param time any?
--- @return string
function vim.fn.reltimestr(time) end

-- FileType event has been triggered at least once.  Can be used
-- 		to avoid triggering the FileType event again in the scripts
-- 		that detect the file type. |FileType|
-- 		Returns |FALSE| when `:setf FALLBACK` was used.
-- 		When editing another file, the counter is reset, thus this
-- 		really checks if the FileType event has been triggered for the
-- 		current buffer.  This allows an autocommand that starts
-- 		editing another buffer to set 'filetype' and load a syntax
-- 		file.
--- @return number
function vim.fn.did_filetype() end

-- Send the {string} to {server}.  The string is sent as an
-- 		expression and the result is returned after evaluation.
-- 		The result must be a String or a |List|.  A |List| is turned
-- 		into a String by joining the items with a line break in
-- 		between (not at the end), like with join(expr, "\n").
-- 		If {idvar} is present and not empty, it is taken as the name
-- 		of a variable and a {serverid} for later use with
-- 		|remote_read()| is stored there.
-- 		If {timeout} is given the read times out after this many
-- 		seconds.  Otherwise a timeout of 600 seconds is used.
-- 		See also |clientserver| |RemoteReply|.
-- 		This function is not available in the |sandbox|.
-- 		Note: Any errors will cause a local error message to be issued
-- 		and the result will be the empty string.
--
-- 		Variables will be evaluated in the global namespace,
-- 		independent of a function currently being active.  Except
-- 		when in debug mode, then local function variables and
-- 		arguments can be evaluated.
--
-- 		Examples: >
-- 			:echo remote_expr("gvim", "2+2")
-- 			:echo remote_expr("gvim1", "b:current_syntax")
-- <
--- @param server any?
--- @param string any?
--- @param idvar any?
--- @param timeout any?
--- @return string
function vim.fn.remote_expr(server, string, idvar, timeout) end

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @param lnum any?
--- @return number
function vim.fn.diff_filler(lnum) end

-- Move the Vim server with the name {server} to the foreground.
-- 		This works like: >
-- 			remote_expr({server}, "foreground()")
-- <		Except that on Win32 systems the client does the work, to work
-- 		around the problem that the OS doesn't always allow the server
-- 		to bring itself to the foreground.
-- 		Note: This does not restore the window if it was minimized,
-- 		like foreground() does.
-- 		This function is not available in the |sandbox|.
-- 		{only in the Win32 GUI and the Win32 console version}
--- @param server any?
--- @return number
function vim.fn.remote_foreground(server) end

-- Returns the highlight ID for diff mode at line {lnum} column
-- 		{col} (byte index).  When the current line does not have a
-- 		diff change zero is returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		{col} is 1 for the leftmost column, {lnum} is 1 for the first
-- 		line.
-- 		The highlight ID can be used with |synIDattr()| to obtain
-- 		syntax information about the highlighting.
--- @param lnum any?
--- @param col any?
--- @return number
function vim.fn.diff_hlID(lnum, col) end

-- Returns a positive number if there are available strings
-- 		from {serverid}.  Copies any reply string into the variable
-- 		{retvar} if specified.  {retvar} must be a string with the
-- 		name of a variable.
-- 		Returns zero if none are available.
-- 		Returns -1 if something is wrong.
-- 		See also |clientserver|.
-- 		This function is not available in the |sandbox|.
-- 		Examples: >
-- 			:let repl = ""
-- 			:echo "PEEK: ".remote_peek(id, "repl").": ".repl
--- @param serverid any?
--- @param retvar any?
--- @return number
function vim.fn.remote_peek(serverid, retvar) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @param expr any?
--- @return number
function vim.fn.empty(expr) end

-- Return the oldest available reply from {serverid} and consume
-- 		it.  Unless a {timeout} in seconds is given, it blocks until a
-- 		reply is available.
-- 		See also |clientserver|.
-- 		This function is not available in the |sandbox|.
-- 		Example: >
-- 			:echo remote_read(id)
-- <
--- @param serverid any?
--- @param timeout any?
--- @return string
function vim.fn.remote_read(serverid, timeout) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

-- Send the {string} to {server}.  The string is sent as input
-- 		keys and the function returns immediately.  At the Vim server
-- 		the keys are not mapped |:map|.
-- 		If {idvar} is present, it is taken as the name of a variable
-- 		and a {serverid} for later use with remote_read() is stored
-- 		there.
-- 		See also |clientserver| |RemoteReply|.
-- 		This function is not available in the |sandbox|.
--
-- 		Note: Any errors will be reported in the server and may mess
-- 		up the display.
-- 		Examples: >
-- 		:echo remote_send("gvim", ":DropAndReply ".file, "serverid").
-- 		 \ remote_read(serverid)
--
-- 		:autocmd NONE RemoteReply *
-- 		 \ echo remote_read(expand("<amatch>"))
-- 		:echo remote_send("gvim", ":sleep 10 | echo ".
-- 		 \ 'server2client(expand("<client>"), "HELLO")<CR>')
-- <
--- @param server any?
--- @param string any?
--- @param idvar any?
--- @return string
function vim.fn.remote_send(server, string, idvar) end

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @param string any?
--- @param chars any?
--- @return string
function vim.fn.escape(string, chars) end

-- Become the server {name}.  This fails if already running as a
-- 		server, when |v:servername| is not empty.
--- @param name any?
--- @return none
function vim.fn.remote_startserver(name) end

-- Make a |List| out of {expr}.  When {pattern} is omitted or
-- 		empty each white-separated sequence of characters becomes an
-- 		item.
-- 		Otherwise the string is split where {pattern} matches,
-- 		removing the matched characters. 'ignorecase' is not used
-- 		here, add \c to ignore case. |/\c|
-- 		When the first or last item is empty it is omitted, unless the
-- 		{keepempty} argument is given and it's non-zero.
-- 		Other empty items are kept when {pattern} matches at least one
-- 		character or when {keepempty} is non-zero.
-- 		Example: >
-- 			:let words = split(getline('.'), '\W\+')
-- <		To split a string in individual characters: >
-- 			:for c in split(mystring, '\zs')
-- <		If you want to keep the separator you can also use '\zs' at
-- 		the end of the pattern: >
-- 			:echo split('abc:def:ghi', ':\zs')
-- <			['abc:', 'def:', 'ghi'] ~
-- 		Splitting a table where the first element can be empty: >
-- 			:let items = split(line, ':', 1)
-- <		The opposite function is |join()|.
--- @param expr any?
--- @param pat any?
--- @param keepempty any?
--- @return list
function vim.fn.split(expr, pat, keepempty) end

-- Returns 1 when inside an event handler.  That is that Vim got
-- 		interrupted while waiting for the user to type a character,
-- 		e.g., when dropping a file on Vim.  This means interactive
-- 		commands cannot be used.  Otherwise zero is returned.
--- @return number
function vim.fn.eventhandler() end

-- This function checks if an executable with the name {expr}
-- 		exists.  {expr} must be the name of the program without any
-- 		arguments.
-- 		executable() uses the value of $PATH and/or the normal
-- 		searchpath for programs.		*PATHEXT*
-- 		On Windows the ".exe", ".bat", etc. can
-- 		optionally be included.  Then the extensions in $PATHEXT are
-- 		tried.  Thus if "foo.exe" does not exist, "foo.exe.bat" can be
-- 		found.  If $PATHEXT is not set then ".exe;.com;.bat;.cmd" is
-- 		used.  A dot by itself can be used in $PATHEXT to try using
-- 		the name without an extension.  When 'shell' looks like a
-- 		Unix shell, then the name is also tried without adding an
-- 		extension.
-- 		On Windows it only checks if the file exists and
-- 		is not a directory, not if it's really executable.
-- 		On Windows an executable in the same directory as Vim is
-- 		always found (it is added to $PATH at |startup|).
-- 		The result is a Number:
-- 			1	exists
-- 			0	does not exist
-- 			-1	not implemented on this system
-- 		|exepath()| can be used to get the full path of an executable.
--- @param expr any?
--- @return number
function vim.fn.executable(expr) end

-- Get the output of {cmd} as a |string| (use |systemlist()| to
-- 		get a |List|). {cmd} is treated exactly as in |jobstart()|.
-- 		Not to be used for interactive commands.
--
-- 		If {input} is a string it is written to a pipe and passed as
-- 		stdin to the command.  The string is written as-is, line
-- 		separators are not changed.
-- 		If {input} is a |List| it is written to the pipe as
-- 		|writefile()| does with {binary} set to "b" (i.e. with
-- 		a newline between each list item, and newlines inside list
-- 		items converted to NULs).
-- 		When {input} is given and is a valid buffer id, the content of
-- 		the buffer is written to the file line by line, each line
-- 		terminated by NL (and NUL where the text has NL).
-- 								*E5677*
-- 		Note: system() cannot write to or read from backgrounded ("&")
-- 		shell commands, e.g.: >
-- 		    :echo system("cat - &", "foo"))
-- <		which is equivalent to: >
-- 		    $ echo foo | bash -c 'cat - &'
-- <		The pipes are disconnected (unless overridden by shell
-- 		redirection syntax) before input can reach it. Use
-- 		|jobstart()| instead.
--
-- 		Note: Use |shellescape()| or |::S| with |expand()| or
-- 		|fnamemodify()| to escape special characters in a command
-- 		argument.  Newlines in {cmd} may cause the command to fail.
-- 		The characters in 'shellquote' and 'shellxquote' may also
-- 		cause trouble.
--
-- 		Result is a String.  Example: >
-- 		    :let files = system("ls " .  shellescape(expand('%:h')))
-- 		    :let files = system('ls ' . expand('%:h:S'))
--
-- <		To make the result more system-independent, the shell output
-- 		is filtered to replace <CR> with <NL> for Macintosh, and
-- 		<CR><NL> with <NL> for DOS-like systems.
-- 		To avoid the string being truncated at a NUL, all NUL
-- 		characters are replaced with SOH (0x01).
--
-- 		The command executed is constructed using several options when
-- 		{cmd} is a string: 'shell' 'shellcmdflag' {cmd}
--
-- 		The resulting error code can be found in |v:shell_error|.
-- 		This function will fail in |restricted-mode|.
--
-- 		Note that any wrong value in the options mentioned above may
-- 		make the function fail.  It has also been reported to fail
-- 		when using a security agent application.
-- 		Unlike ":!cmd" there is no automatic check for changed files.
-- 		Use |:checktime| to force a check.
--- @param cmd any?
--- @param input any?
--- @return string
function vim.fn.system(cmd, input) end

