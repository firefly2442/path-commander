extends Node

signal set_tutorial_level(level)

func _ready():
	Game.level_node = preload("res://scenes/TutorialLevel.tscn").instance()
	var _c = self.connect("set_tutorial_level", Game.level_node, "_on_Node_set_tutorial_level")


func _on_Tutorial_1_btn_pressed():
	emit_signal("set_tutorial_level", 1)
	_swapTutorial()

func _on_Tutorial_2_btn_pressed():
	emit_signal("set_tutorial_level", 2)
	_swapTutorial()

func _on_Tutorial_3_btn_pressed():
	emit_signal("set_tutorial_level", 3)
	_swapTutorial()

func _on_Tutorial_4_btn_pressed():
	emit_signal("set_tutorial_level", 4)
	_swapTutorial()

func _on_Tutorial_5_btn_pressed():
	emit_signal("set_tutorial_level", 5)
	_swapTutorial()

func _swapTutorial():
	get_tree().get_root().add_child(Game.level_node)
	get_tree().set_current_scene(Game.level_node)
	var tut = get_tree().get_root().find_node("TutorialSelection", true, false)
	get_tree().get_root().remove_child(tut)
	tut.queue_free()

func _on_Back_btn_pressed():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == OK, "Error swapping scene")

func _exit_tree():
	self.queue_free()
