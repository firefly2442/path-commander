extends TextureButton


func _ready():
	get_parent().left = true
	get_parent().down = true
	var _c = self.connect("pressed", self.get_parent(), "_on_TextureButton_pressed") 
