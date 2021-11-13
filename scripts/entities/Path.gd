extends TextureButton

var up: bool = false
var down: bool = false
var left: bool = false
var right: bool = false

func _ready():
	pass

func _on_TextureButton_pressed():
	self.set_rotation_degrees(self.get_rotation_degrees() + 90)
	
	var new_up: bool = false
	var new_down: bool = false
	var new_left: bool = false
	var new_right: bool = false
	if up:
		new_right = true
	if right:
		new_down = true
	if down:
		new_left = true
	if left:
		new_up = true

	if new_up:
		up = true
	else:
		up = false
	if new_down:
		down = true
	else:
		down = false
	if new_left:
		left = true
	else:
		left = false
	if new_right:
		right = true
	else:
		right = false

	Game.checkEvent()
