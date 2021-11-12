extends Node

signal set_tutorial_level(level)

func _ready():
	# TutorialLevel is setup via autoload
	var _c = self.connect("set_tutorial_level", TutorialLevel, "_on_Node_set_tutorial_level")


func _on_Tutorial_1_btn_pressed():
	emit_signal("set_tutorial_level", 1)
	assert(get_tree().change_scene("res://scenes/TutorialLevel.tscn") == OK, "Error swapping scene")

func _on_Tutorial_2_btn_pressed():
	emit_signal("set_tutorial_level", 2)
	assert(get_tree().change_scene("res://scenes/TutorialLevel.tscn") == OK, "Error swapping scene")

func _on_Tutorial_3_btn_pressed():
	emit_signal("set_tutorial_level", 3)
	assert(get_tree().change_scene("res://scenes/TutorialLevel.tscn") == OK, "Error swapping scene")

func _on_Tutorial_4_btn_pressed():
	emit_signal("set_tutorial_level", 4)
	assert(get_tree().change_scene("res://scenes/TutorialLevel.tscn") == OK, "Error swapping scene")

func _on_Tutorial_5_btn_pressed():
	emit_signal("set_tutorial_level", 5)
	assert(get_tree().change_scene("res://scenes/TutorialLevel.tscn") == OK, "Error swapping scene")
