extends Control

var tutorial_level: int = 0
var board_rows: int = 0
var board_cols: int = 0

func _ready():
	var _c = Game.connect("won", self, "_on_win")
	Game.resetResults()
	Game.result_run_stopwatch = true

func _on_Node_set_tutorial_level(level):
	Game.gametype = "tutorial"
	tutorial_level = level
	var scene = load("res://scenes/tutorials/tutorial_level_" + str(level) + ".tscn")
	self.find_node("Board").add_child(scene.instance())
	self.find_node("TutorialLabel").set_text("Tutorial " + str(level))
	
	# figure out the rows x columns dimensions of the game board and save for later
	var board = self.find_node("GridBoard", true, false)
	self.board_cols = board.columns
	self.board_rows = board.get_child_count() / board.columns

func _exit_tree():
	Game.level_node.queue_free()
	Game.level_node = null
	self.queue_free()

func _on_win():
	assert(get_tree().change_scene("res://scenes/FinishLevel.tscn") == OK, "Error swapping scene")
