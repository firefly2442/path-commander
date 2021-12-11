extends Node

signal set_tutorial_level(level)

func _ready():
	Game.level_node = preload("res://scenes/Level.tscn").instance()
	Game.gametype = "tutorial"
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
	var board = Game.level_node.find_node("GridBoard", true, false)
	Game.level_node.board_cols = board.columns
	Game.level_node.board_rows = board.get_child_count() / board.columns

func _on_Back_btn_pressed():
	var _c = get_tree().change_scene("res://scenes/MainMenu.tscn")

func _exit_tree():
	self.queue_free()
