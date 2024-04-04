extends TextureButton


func _ready():
	get_parent().left = true
	get_parent().right = true
	var _c = self.connect("pressed", Callable(self.get_parent(), "_on_TextureButton_pressed")) 
