.PHONY: all

all:
	nvim --headless -u NONE -c 'luafile ./lua/lua-dev/parser.lua' -c qa
