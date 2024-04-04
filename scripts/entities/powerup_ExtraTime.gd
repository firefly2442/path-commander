extends TextureButton

func _ready():
	var _c = self.connect("pressed", Callable(self.get_parent(), "_on_TextureButton_pressed")) 

