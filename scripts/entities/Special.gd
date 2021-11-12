extends TextureButton

var up: bool = false
var down: bool = false
var left: bool = false
var right: bool = false

func _ready():
	if self.get_rotation_degrees() == 0:
		up = true
	elif self.get_rotation_degrees() == 90:
		right = true
	elif self.get_rotation_degrees() == 180:
		down = true
	elif self.get_rotation_degrees() == 270:
		left = true
