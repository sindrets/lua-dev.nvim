# Updating Lua API Docs

1. Clone the neovim repo somewhere on your system
2. Run `neovim/scripts/gen_vimdoc.py`
3. Copy `mpack` files to the **lua-dev.nvim** data directory
4. Open the file `./lua/lua-dev/parser.lua` in Neovim
5. Execute `:luafile %`
6. Create a PR with new EmmyLua annotations
