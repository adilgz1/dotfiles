# nvim notes

## changelog (starting from april 4th)
* changed dressing.nvim to snacks
* updated to nvim 0.12
* added `<leader>h` bind for Huefy (minty)
* added oil plugin
* added surround plugin
* added fzf-lua
* alpha.lua welcome screen code was causing the 'Telescope command not found' error. Updated that for fzf-lua binds
* added render-markdown
* moved tmux config to ~/.config/tmux/tmux.conf and shell aliases to ~/.config/tmux/aliases.sh
* removed mini-surround so `s` works with no delay
* added live-preview to preview md and html files. might work with others havent checked yet.
* added nvim-lspconfig, mason, mason-lspconfig, mason-tool-installer
* added blink.cmp and added lsp as a source for it
* changed cw and dw to do what ciw and diw do
* added outline.nvim. see documentation for commands and binds.
* fixed basedpyright typechecking in its config. also made changes in pyproject.toml file in manim project because .toml files override the global lsp config. 

## TODO
* learn more about what the _text object (not motion)_ `i` does. `viw` selects the word we are on. `i` means "inside". `iw` means "inside current word". see how this works with substitute.lua  
* learn more about registers, accessed by `"`
* ALWAYS remember to run `:LivePreview close` before closing browser window for live-preview. otherwise it wont start up again as the port will still be in use.
* set up a tex lsp or vimtex. figure out which one is better.

## useful commands to remember (AND USE OFTEN)

### tmux
* `<prefix>c` to create new window, `<prefix>&` to close current window.

### nvim
* `q[key]` to record a macro inside `[key]`. the macro is assigned to the register under `[key]`
* `.` repeats a command. if i press `dw` to delete a word then i navigate to another word i can press `.` to repeat the `dw` command
* super powerful. `diw` will delete inside word. `ciw` will change inside current word. `di"` will delete inside `""` quotes. `ci[` will change inside brackets. `cit` will change inside html tags.
* `/[string]` is a _motion_ till the next instance os "string". i can type `c/[string]` to change the text till the "string"

## cool commands to remember (that aren't used often)
### tmux 
* save session with `<prefix> <C-s>`. 
* when terminal relaunches enter tmux with the command `tmux` and use `<prefix> <C-r>` to reload. then you can navigation sessions with `<prefix>s`
* press `<prefix>w` to see all sessions and their windows open
* use `<prefix>:` to enter commands while in a tmux session. can add session by entering the command `new-session -n [name]` 
* `:Lazy reload [plugin].nvim` to reload plugin inside nvim
* `:!` to run shell command while in nvim
* added ta, td, tn, tl and tk as aliases for tmux commands in ~/.config/tmux/aliases.sh
* `<prefix>[` enters copy mode. can use VI motions to scroll through the terminal commands in a tmux pane. can yank. `q` to exit.

### nvim 
* `t, [character]` is a motion that goes "till" the entered character, `f, [character]` goes upto and includes the entered character
* `n, t/f, [character]` goes to the nth character after the cursor
* `u` for undo. `<C-r>` to redo in normal mode.
* search within a file, and go through results 
    - type `/, [searchstring], <enter>` and `n`/`N` to cycle through the results forwards/backwards
    - type `*`/`#` to search forwards/backwards for the word under the current cursor
    - `:noh<enter>` to clear search highlights
* Registers
    - press `"` to access registers.
    - "ayy — yank the current line into register a
    - "ap — paste from register a
    - "+y — yank into the system clipboard (register +)
    - "+p — paste from the system clipboard
    - " — the default register (last yank/delete)
    - \+ — system clipboard
    - \* — system selection (on Linux)
    - 0 — last yank specifically (not affected by deletes)
    - 1-9 — last 9 deletes, most recent first
    - _ — black hole register (delete without saving)

* to search and replace, use the substitute command:`:%s/old/new/g`

    - this replaces all occurrences of "old" with "new" in the entire file
    - If you want to confirm each replacement before it happens, add `c`:`:%s/old/new/gc`
    - `:s/old/new/g` — only the current line
    - `:5,10s/old/new/g` — lines 5 through 10
    - `:'<,'>s/old/new/g` — visual selection
