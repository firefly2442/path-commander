extends Control

var board_rows: int = 0
var board_cols: int = 0

func _ready():
	# set the rows x columns dimensions of the game board from the previous page
	var board = self.find_node("GridBoard", true, false)
	board.columns = self.board_cols
	
	# generate random placement of board pieces
	
	
	
	Game.gametype = "survival"
	
	Game.resetResults()
	Game.result_run_stopwatch = true
	
	Game.timer.start()

func _exit_tree():
	self.queue_free()

func _on_win():
	assert(get_tree().change_scene("res://scenes/FinishLevel.tscn") == OK, "Error swapping scene")

func _on_loss():
	assert(get_tree().change_scene("res://scenes/FinishLevel.tscn") == OK, "Error swapping scene")
