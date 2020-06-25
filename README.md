# Salmon Cannon
Interactive tool for managing Fish Shell's `$fish_user_paths` variable

![salmon cannon](https://media.giphy.com/media/ik8lXkIOAyxq7SNuU0/giphy.gif)

Fish Shell has a really neat way in managing `$PATH` by adding to or removing elements from the `$fish_user_paths` variable-list. https://fishshell.com/docs/current/tutorial.html#path
>... A faster way is to modify the $fish_user_paths universal variable, which is automatically prepended to $PATH.

However, each time I need to edit `$fish_user_paths` I completely forget how to do it or if I do remember, I usually fat finger something or accidently delete the wrong thing.

So I made a function that will launch an _interactive_ 🧙‍♂️ session for managing `$fish_user_paths`.

## Installation

Fisher
```
fisher add lastcontinue/salmon_cannon
```

Oh-my-fish
```
omf install https://github.com/lastcontinue/salmon_cannon
```

## Usage


running `salmon_cannon` with no options will start the interactive session, this is probably what you want the first time. **Note**: When you add a path, you just type out the path -> `/usr/local/something/bin` etc.  

However, when you delete, **you need to use the index of the path you want to delete**  
If you hit `d` to delete, and then type out `/usr/local/something/bin` it's not going to work how you want it to work.

<img width="434" alt="Screen Shot 2020-03-19 at 6 56 12 PM" src="https://user-images.githubusercontent.com/20746446/77856504-48103200-71bd-11ea-8a63-b866d745f435.png">

>"Yeah, but interactive modes are for N00bs"

Calm down, also made some options you can pass in:

`salmon_cannon -a <path>`  
`salmon_cannon --add <path>`
This will just add a path to `$fish_user_paths`

`salmon_cannon -d <index>`  
`salmon_cannon --delete <index>` 
This will delete an element from the `$fish_user_paths` variable (Use `salmon_cannon -l` to list the current indexes)

`salmon_cannon -l`  
`salmon_cannon --list`  
This just lists out the current `$fish_user_paths` with the index next to the item

>"I hate this name, too long"  

Fish has amazing abbreviation cabilities. "Go nuts"
https://fishshell.com/docs/current/cmds/abbr.html  
(or fork this repo and change the name if you really want to go to that effort)

>"I hate the rest of this, but listing out `$fish_user_paths` is great"  

I abstracted `print_fish_user_paths` into it's own function because I could see this being useful for other people wanting to pipe into other commands.
