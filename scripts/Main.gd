extends Node

func _ready():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == OK, "Error swapping scene")
	
func _exit_tree():
	self.queue_free()
