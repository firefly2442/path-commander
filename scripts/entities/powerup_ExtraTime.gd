extends TextureButton

func _ready():
	var _c = self.connect("pressed", self.get_parent(), "_on_TextureButton_pressed") 

