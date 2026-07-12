# plugin notes

## changelog (starting from april 4th)
* changed dressing.nvim to snacks

## decide between telescope and fzf-lua
* AND parameter in search i.e. searching for files with "string1" AND "string2"

## things to learn
* learn more about what the _motion_ `i` does. `viw` selects the word we are on. `i` means "inside". `iw` means "inside current word". see how this works with substitute.lua  
* learn more about registers, accessed by `"`

## useful commands to rememeber (AND USE OFTEN)
* `<prefix>c` to create new window, `<prefix>&` to close current window.
* `q[key]` to record a macro inside `[key]`. the macro is assigned to the register under `[key]`


## cool commands to remember (that aren't used often)
### tmux 
* save session with `<prefix> <C-s>`. 
* when terminal relaunches enter tmux with the command `tmux` and use `<prefix> <C-r>` to reload. then you can navigation sessions with `<prefix>s`
* press `<prefix>w` to see all sessions and their windows open
* use `<prefix>:` to enter commands while in a tmux session. can add session by entering the command `new-session -n [name]` 
* `:Lazy reload [plugin].nvim` to reload plugin inside nvim
* `:!` to run shell command while in nvim
* added ta, td, tn, tl and tk as aliases for tmux commands in ~/.config/tmux/aliases.sh


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
