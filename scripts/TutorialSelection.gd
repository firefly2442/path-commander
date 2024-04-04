extends Node

func _ready():
	Game.level_node = preload("res://scenes/Level.tscn").instantiate()
	Game.gametype = "tutorial"

func _on_Tutorial_1_btn_pressed():
	Game.level_node.set_tutorial_level(1)
	_swapTutorial()

func _on_Tutorial_2_btn_pressed():
	Game.level_node.set_tutorial_level(2)
	_swapTutorial()

func _on_Tutorial_3_btn_pressed():
	Game.level_node.set_tutorial_level(3)
	_swapTutorial()

func _on_Tutorial_4_btn_pressed():
	Game.level_node.set_tutorial_level(4)
	_swapTutorial()

func _on_Tutorial_5_btn_pressed():
	Game.level_node.set_tutorial_level(5)
	_swapTutorial()

func _swapTutorial():
	get_tree().get_root().add_child(Game.level_node)
	get_tree().set_current_scene(Game.level_node)
	var tut = get_tree().get_root().find_child("TutorialSelection", true, false)
	get_tree().get_root().remove_child(tut)
	tut.queue_free()
	var board = Game.level_node.find_child("GridBoard", true, false)
	Game.level_node.board_cols = board.columns
	Game.level_node.board_rows = board.get_child_count() / board.columns

func _on_Back_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/MainMenu.tscn")

func _exit_tree():
	self.queue_free()
