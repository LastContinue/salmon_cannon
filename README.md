# Salmon Cannon
Interactive tool for managing Fish Shell's `$fish_user_paths` variable

![salmon cannon](https://media.giphy.com/media/ik8lXkIOAyxq7SNuU0/giphy.gif)

Fish Shell has a really neat way of managing `$PATH` by adding to, or removing elements from, the `$fish_user_paths` variable-list. https://fishshell.com/docs/current/tutorial.html#path
>... A faster way is to modify the $fish_user_paths universal variable, which is automatically prepended to $PATH.

However, each time I need to edit `$fish_user_paths` I completely forget how to do it or if I do remember, I usually fat finger something or accidently delete the wrong thing. Fish 3 helps with the addition of the `-a` and `-p` flags for adding elements to lists, but it's still to easy to screw up when deleting from them.

So I made a tool that will launch an _interactive_ 🧙‍♂️ session for managing `$fish_user_paths`.

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

Running `salmon_cannon` with no options will start the interactive session. This is probably what you want the first time.

<img width="672" alt="salmon_cannon interactive mode" src="https://user-images.githubusercontent.com/20746446/96319454-585ef180-0fd5-11eb-945e-1f91bb2bb5d3.png">

You can add a path by [a]ppending (add to end of list), or [p]repending (beginning of list). After making your selection, just enter the path (no quotes required)

When you [d]elete a path, you can enter either enter the `index` of the path, or the actual `path`.  For the example above, I entered `2`, but entering `/usr/local/opt/fzf/bin` would have done the same thing.

It will tell you if you've entered something clearly not valid (however it doesn't go as far as making sure that all paths in `$_fish_user_paths` are valid. That's still up to you at this point in time, and there are cases where you might want to enter a non valid path, so that you can then create it later, etc. It would prevent "foot-shooting" to an extent though, so I may add that later)

<img width="646" alt="salmon_cannon checking for valid input" src="https://user-images.githubusercontent.com/20746446/96319632-d6bb9380-0fd5-11eb-96e6-28746bb868ab.png">  

>"Yeah, but interactive modes are for N00bs"

Calm down, also made some options you can pass in:

`salmon_cannon ( -a | --append ) NEW_PATH`  
This will just append a path to `$fish_user_paths`

`salmon_cannon ( -d | --delete ) #INDEX|EXISTING_PATH`  
This will delete an element from the `$fish_user_paths` variable 

`salmon_cannon ( -l | --list )`  
This just lists out the current `$fish_user_paths` with the index before the path of each element

`salmon_cannon ( -p | --prepend ) NEW_PATH`  
This will just prepend a path to `$fish_user_paths`

>"I hate this name, too long"  

Fish has amazing abbreviation cabilities. "Go nuts"
https://fishshell.com/docs/current/cmds/abbr.html  
(or fork this repo and change the name if you really want to go to that effort)

>"Name is alright, don't like the underscore though..."  

Yeah... maybe in retrospect it should have been a `-` 🤷‍♂️

>"I hate the rest of this, but listing out `$fish_user_paths` is great"  

I abstracted `print_fish_user_paths` into its own function because I could see this being useful for other people wanting to pipe into other commands. It just wraps  
```
echo $fish_user_paths | tr " " "\n" | nl
```
with some nice fluff, but it could be useful to _someone_.

## Fish 3 / Behind the Scenes
One of the many neat features added in Fish 3 was the `--append` and `--prepend` flags for [set](https://fishshell.com/docs/current/cmds/set.html). These additions make this little tool less valuable to the lazy person (me), but it's still a fun little project for me.  

For adding a new path, you can simply just do 
```
set -Ua fish_user_paths /usr/local/sbin
```
or
```
set -Up fish_user_paths /usr/local/sbin
```
Depending on the order you want your paths. Deleting is a bit more tricky, so this tool is still a good choice for streamlining your efforts. You'd want to do something like  

```
set -l index contains -i /usr/local/sbin $fish_user_paths
set -e fish_user_paths[$index]
```  

Of course you could do that as a one-liner, but let's give readbility a chance.