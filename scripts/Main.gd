extends Node

func _ready():
	var _c = get_tree().change_scene("res://scenes/MainMenu.tscn")
	
func _exit_tree():
	self.queue_free()
