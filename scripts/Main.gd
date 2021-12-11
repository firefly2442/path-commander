extends Node

func _ready():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	
func _exit_tree():
	self.queue_free()
