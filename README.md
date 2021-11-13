# path-commander

Path Commander is a simple puzzle routing game built in the [Godot game engine](https://godotengine.org).

## Introduction

## Building and Releasing

https://github.com/firebelley/godot-export

## Licenses

* Images from Kenney are under Creative Commons Zero (CC0)
* Fonts from Kenney are under Creative Commons Zero (CC0)
* Roboto font is under Apache Version 2
* GDScript code and all other content is under GPLv3

## Development Notes

* Developed and tested with Godot v3.4
* Use `autoload` to pre-load singletons.  Try *not* to use singletons if possible.
* Use the debugger and the `misc` tab to debug mouse click events.  This can show where in the node hierarchy it's getting stuck.
* If something isn't clickable, traverse up the node tree and set the Mouse -> Filter property to `Ignore`.

## References
