# path-commander

Path Commander is a simple puzzle routing game built in the [Godot game engine](https://godotengine.org).

![Logo](icon.png)

State: `In Development`

## Introduction

The objective is to create a path between two points on a two-dimensional grid by rotating path pieces.

## Building and Releasing

https://github.com/firebelley/godot-export

## Licenses

* Images/Fonts/Sounds from Kenney are under Creative Commons Zero (CC0)
* Roboto font is under Apache Version 2
* GDScript code and all other content is under GPLv3

## Development Notes

* Developed and tested with Godot v3.4
* Use `autoload` to pre-load singletons.  Try *not* to use singletons if possible.
* Use the debugger and the `misc` tab to debug mouse click events.  This can show where in the node hierarchy it's getting stuck.
* If something isn't clickable, traverse up the node tree and set the Mouse -> Filter property to `Ignore`.
* Target screen resolution 1920x1080
* Orphaned/stray nodes are nodes that have exited the scene tree but still exist in memory resulting in a memory leak.  You
can use `get_tree().get_root().print_stray_nodes()` to debug and find them.  If the code ever calls `instance()` but then
discarding it without `add_child()` or if the code is using `remove_child()` without `queue_free()` these are cases that
would create stray nodes.
* The `.ogg` sound files needed to be re-imported with loop turned off to prevent them from continuously playing and looping.

## References and Tutorials

### Youtube Channels

* [Godot Tutorials](https://www.youtube.com/channel/UCnr9ojBEQGgwbcKsZC-2rIg)
* [GDQuest](https://www.youtube.com/c/Gdquest)
* [KidsCanCode](https://www.youtube.com/c/KidscancodeOrg)
