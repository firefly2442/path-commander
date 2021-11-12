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
		new_up = false
		new_right = true
	if right:
		new_right = false
		new_down = true
	if down:
		new_down = false
		new_left = true
	if left:
		new_left = false
		new_up = true
	up = new_up
	down = new_down
	left = new_left
	right = new_right

	Game.checkEvent()
