extends Node


func _ready():
	# TODO: set level node instance
	Game.game_type = "survival"
	Game.level_node = 0
	
	Game.resetResults()
	Game.result_run_stopwatch = true
