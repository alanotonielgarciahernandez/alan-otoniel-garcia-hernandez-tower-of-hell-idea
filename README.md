<div align='center'>

  #### Alan Otoniel García Hernández Tower of Hell Idea.
</div>

# Current state
It seems the game is kind of unplayable. Work has already begun on reviewing the project to resolve all the issues.

# Information
Started in December, 2021. This experience is a copy of the original Tower of Hell game, [ Tower of Hell ]( https://www.roblox.com/games/1962086868/Tower-of-Hell ) by YXCeptional Studios. The lobby, the sections, and the rest of the gameplay content come from that game. This repository is the Rojo export of my published copy, kept so I can read and version those files outside Roblox Studio.

I published the copy to test what I knew. I do not earn anything from it beyond that practice. Bugs can still appear while playing, and I only fix or extend the place when I decide to.

The copy includes:
- A lobby and twelve tower sections saved as models.
- A round that stacks six random sections, then an end platform, and clears them when the timer reaches zero.
- A timer, a map bar that follows the player's height, and a points store that can add time.

`ServerScriptService.Server` starts the round, the clock, the points, the lobby, and the kill parts. `ReplicatedStorage.Client` starts the timer label, the points store, and the map bar. `ReplicatedStorage.Modules.LevelModule` stores each section's name, author, and color. The twelve sections, the blank `LevelTemplate`, and the end platform live in `ServerStorage`.

# How to use

## Requirements
[ Roblox Studio ]( https://create.roblox.com/ ) and [ Rokit ]( https://github.com/rojo-rbx/rokit ) are required. Rokit installs the tool versions pinned in `rokit.toml`.

Install the project tools by opening a shell and running the following command inside the project folder:
```sh
rokit install
```
Install the matching Studio plugin once:
```sh
rojo plugin install
```
Restart Studio after installing the plugin.

## Open the place
`game.rbxl` is the local copy of the published place. It is ignored by Git. Open that file in Roblox Studio, then start the Rojo server from the project folder:
```sh
rojo serve
```
In Studio, connect the Rojo plugin to the server. The plugin syncs `src` into the open place.

## Build the project
Open a shell and run the command below to build a place file from this repository.
```sh
rojo build -o "alan-otoniel-garcia-hernandez-tower-of-hell-idea.rbxlx"
```
The built file is ignored by Git. Open it in Roblox Studio when you want a place generated only from the files in this repository.

## Check the scripts
Format, lint, and run the point tests from the project folder:
```sh
stylua src tests
selene src tests
lune run tests/Points.spec
```
The tests live in `tests` and are not synced into the place.

# Functions
The gameplay below is copied from the original game. A timer counts down while players climb a stack of sections. Reaching the end awards points. When the timer reaches zero, everyone returns to the lobby and a new tower is built.

## The tower.
`Tower` clones six sections at random from the twelve models in `ServerStorage`. Each section is stacked above the last and turned so the next one does not face the same way. The section name and author are written on its wall, and the matching slot on the map GUI takes that section's color. An end platform is placed on top. Parts tagged `Kill` remove the character's health on touch.

## The timer.
`ReplicatedStorage.Value` is the time left. `Timer` subtracts one from it every second, and counts again after each round sets the clock back. The timer label shows that number. `ReplicatedStorage.Remotes.BTEvent` can add 30 seconds when the points store spends 100 points.

## The climb.
Players start in the lobby. The lobby teleport sends a character who touches it to the start of the end platform. The map GUI moves a bar from the character's height. Touching the win part on the end platform adds 100 points on the server and sends the character above the lobby spawn. The balance stays on the player, so respawning does not clear it.

## Round end.
The round waits until `ReplicatedStorage.Value` is zero. The timer is set back to the number that object started with, characters are moved to the lobby spawn, and the six sections and the end platform are removed. The loop then builds another tower.

# Technologies
- Programming Language: [ Luau ]( https://luau.org/ )
- Engine: [ Roblox ]( https://create.roblox.com/ )
- Project Sync: [ Rojo ]( https://github.com/rojo-rbx/rojo ) 7.7.1
- Toolchain Manager: [ Rokit ]( https://github.com/rojo-rbx/rokit )
- Formatter: [ StyLua ]( https://github.com/JohnnyMorganz/StyLua ) 2.6.0
- Linter: [ Selene ]( https://github.com/Kampfkarren/selene ) 0.32.0
- Test runner: [ Lune ]( https://github.com/lune-org/lune ) 0.11.1
