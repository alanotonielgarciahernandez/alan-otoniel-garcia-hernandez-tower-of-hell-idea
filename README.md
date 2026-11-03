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

`Replicate Level.server.luau` builds each tower. `Timer.server.luau` counts down `Workspace.Value`. `LevelModule.luau` stores each section's name, author, and color.

# How to use

## Requirements
[ Roblox Studio ]( https://create.roblox.com/ ) and [ Rokit ]( https://github.com/rojo-rbx/rokit ) are required. Rokit installs the Rojo version pinned in `rokit.toml`.

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

# Functions
The gameplay below is copied from the original game. A timer counts down while players climb a stack of sections. Reaching the end awards points. When the timer reaches zero, everyone returns to the lobby and a new tower is built.

## The tower.
`Replicate Level` clones six sections at random from the twelve models in `ReplicatedStorage`. Each section is stacked above the last and turned so the next one does not face the same way. The section name and author are written on its wall, and the matching slot on the map GUI takes that section's color. An end platform is placed on top.

## The timer.
`Workspace.Value` is the time left. `Timer.server.luau` subtracts one from it every second until it reaches zero. The timer GUI shows that number. `BTEvent` can add time when the points store asks for it.

## The climb.
Players start in the lobby. A part in the lobby sends a character who touches it to the start of the end platform's path. The map GUI moves a bar from the character's height. Touching the win part on the end platform adds points.

## Round end.
The round waits until `Workspace.Value` is zero. The timer is set back to 180, characters are moved to the lobby spawn, and the six sections and the end platform are removed. The loop then builds another tower.

# Technologies
- Programming Language: [ Luau ]( https://luau.org/ )
- Engine: [ Roblox ]( https://create.roblox.com/ )
- Project Sync: [ Rojo ]( https://github.com/rojo-rbx/rojo ) 7.7.1
- Toolchain Manager: [ Rokit ]( https://github.com/rojo-rbx/rokit )
