extends TextureButton

func _ready():
	get_parent().up = true
	get_parent().down = true
	get_parent().left = true
	get_parent().right = true
	
	self.get_parent().type = "end"
