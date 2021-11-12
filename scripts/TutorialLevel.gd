extends Control

var tutorial_level: int = 0

func _ready():
	Game.gametype = "tutorial"

func _on_Node_set_tutorial_level(level):
	tutorial_level = level
	var scene = load("res://scenes/tutorials/tutorial_level_" + str(level) + ".tscn")
	var instance = scene.instance()
	self.find_node("Board").add_child(instance)
	self.find_node("TutorialLabel").set_text("Tutorial " + str(level))

func _exit_tree():
	self.queue_free()
