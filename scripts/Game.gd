extends Node

var level_node
var gametype: String = ""
var recursive_checked: Array = []
var infinite_mode: bool = false

var result_string: String = ""
# counts up as a stopwatch to store how long a level took
var result_run_stopwatch: bool = false
var result_stopwatch: float = 0
var result_num_clicks: int = 0
var result_puzzles_completed: int = 0

var timer: Timer = Timer.new()

var powerups_enabled: bool = false
var powerup_in_play: bool = false
var powerup_timer: Timer = Timer.new()

signal won
signal lost

var _reset_board_mutex: bool = false

func _ready():
	self.add_child(self.timer)
	self.timer.one_shot = true
	var _c = self.timer.connect("timeout", Callable(self, "_on_timer_timeout")) 
	
	self.add_child(self.powerup_timer)
	self.powerup_timer.one_shot = false	
	var _p = self.powerup_timer.connect("timeout", Callable(self, "_on_powerup_timer_timeout"))
	self.powerup_timer.start(12)
	self.powerup_timer.stop()

func _process(delta):
	if result_run_stopwatch:
		self.result_stopwatch += delta

func resetResults():
	self.result_string = ""
	self.result_stopwatch = 0
	self.result_num_clicks = 0
	self.result_puzzles_completed = 0

func checkMouseEvent():
	# increment click event
	self.result_num_clicks += 1
	
	var board = level_node.find_child("GridBoard", true, false)
	# check for win
	var start = board.find_child("Start", true, false)
	self.recursive_checked = []
	recursiveCheckWinPath(level_node, board, start, true)
	
	if _reset_board_mutex:
		for c in board.get_children():
			board.remove_child(c)
		Game.level_node.setupBoard(board)
		_reset_board_mutex = false


func recursiveCheckWinPath(level, board, node, emit):
	self.recursive_checked.append(node)
	if node.name == "End":
		if emit:
			self.result_puzzles_completed += 1
			if self.infinite_mode:
				# reset board later after recursion finishes
				_reset_board_mutex = true
			else:
				AudioManager.play("res://sounds/you_win.ogg")
				self.result_string = "Won"
				self.result_run_stopwatch = false
				self.timer.stop()
				self.powerup_timer.stop()
				emit_signal("won")
		else:
			return true
	
	# find all outbound paths from node
	# check it against the board grid
	var pos = _getXYNodePosition(level, board, node)
	if node.up and (pos[0]-1) > 0 and !recursive_checked.has(_getBoardItemXY(level, board, pos[0]-1, pos[1])) and _getBoardItemXY(level, board, pos[0]-1, pos[1]).down:
		recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0]-1, pos[1]), emit)
	if node.down and (pos[0]+1) <= level.board_rows and !recursive_checked.has(_getBoardItemXY(level, board, pos[0]+1, pos[1])) and _getBoardItemXY(level, board, pos[0]+1, pos[1]).up:
		recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0]+1, pos[1]), emit)
	if node.left and (pos[1]-1) > 0 and !recursive_checked.has(_getBoardItemXY(level, board, pos[0], pos[1]-1)) and _getBoardItemXY(level, board, pos[0], pos[1]-1).right:
		recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0], pos[1]-1), emit)
	if node.right and (pos[1]+1) <= level.board_cols and !recursive_checked.has(_getBoardItemXY(level, board, pos[0], pos[1]+1)) and _getBoardItemXY(level, board, pos[0], pos[1]+1).left:
		recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0], pos[1]+1), emit)

	if !emit:
		return false


func _getBoardItemXY(level, board, row, col):
	var index: int = (((row-1) * level.board_cols) + col)-1
	return board.get_child(index)

func _getXYNodePosition(level, board, node):
	var row: int = 1
	var col: int = 1
	for n in board.get_children():
		if n == node:
			return [row, col]
		col = col + 1
		if col > level.board_cols:
			col = 1
			row = row + 1

func _on_timer_timeout():
	self.result_run_stopwatch = false
	self.timer.stop()
	self.powerup_timer.stop()
	
	if self.infinite_mode:
		self.result_string = "Won"
		AudioManager.play("res://sounds/you_win.ogg")
		emit_signal("won")
	else:
		self.result_string = "Lost"
		AudioManager.play("res://sounds/you_lose.ogg")
		emit_signal("lost")

func _on_powerup_timer_timeout():
	if self.powerup_in_play:
		# remove it from the board
		level_node.swapOutPowerup()
		self.powerup_in_play = false
	else:
		# add one to the board
		level_node.createPowerup()
		self.powerup_in_play = true

func extraTimeClicked():
	if self.gametype == "survival":
		self.timer.start(self.timer.time_left + 5)
	# replace the powerup with a blank
	self.level_node.swapOutPowerup()
	self.powerup_in_play = false

