extends Node

func _ready():
	SceneSwitcher.switch_scene("res://scenes/MainMenu.tscn")
	
func _exit_tree():
	self.queue_free()
