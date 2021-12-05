extends Control

var board_rows: int = 0
var board_cols: int = 0

func _ready():
	var board = self.find_node("GridBoard", true, false)
	
	if Game.gametype == "tutorial":
		$MarginContainer/VBoxContainer/Board.remove_child($MarginContainer/VBoxContainer/Board.get_child(0))

	if Game.gametype == "survival":
		if Game.powerups_enabled:
			Game.powerup_timer.start()
		board.columns = self.board_cols
		
		$MarginContainer/VBoxContainer/HBoxContainer/TitleLabel.text = "Survival"
		
		# generate random placement of board pieces
		_generateRandomBoardPieces(board)
		Game.recursive_checked = []
		# make sure the path doesn't immediately have a solution with no rotations needed OR no blank specials
		while Game.recursiveCheckWinPath(self, board, board.find_node("Start", true, false), false) or !board.find_node("Blank", true, false):
			_generateRandomBoardPieces(board)
			Game.recursive_checked = []
	
	Game.resetResults()
	var _c = Game.connect("won", self, "_on_win")
	_c = Game.connect("lost", self, "_on_loss")
	Game.result_run_stopwatch = true
	
	if Game.gametype == "survival":
		Game.timer.start()
	
func _process(_delta):
	var spinbox = self.find_node("CountdownSpinBox", true, false)
	spinbox.value = Game.timer.time_left

func _exit_tree():
	Game.level_node.queue_free()
	Game.level_node = null
	self.queue_free()

func _on_win():
	assert(get_tree().change_scene("res://scenes/FinishLevel.tscn") == OK, "Error swapping scene")

func _on_loss():
	assert(get_tree().change_scene("res://scenes/FinishLevel.tscn") == OK, "Error swapping scene")

func _on_Node_set_tutorial_level(level):
	Game.gametype = "tutorial"
	var scene = load("res://scenes/tutorials/tutorial_level_" + str(level) + ".tscn")
	self.find_node("Board").add_child(scene.instance())
	self.find_node("TitleLabel").set_text("Tutorial " + str(level))

func _generateRandomBoardPieces(board):
	var rng = RandomNumberGenerator.new()
	rng.randomize() # sets up a random seed
	
	# remove any previous children
	for c in board.get_children():
		board.remove_child(c)
	
	# fill the entire board with pieces
	var astar = AStar2D.new()
	for row in range(1,board_rows+1):
		for col in range(1,board_cols+1):
			astar.add_point(_rowColToIndex(row, col), Vector2(row, col))
			# generate a random piece
			var piece_index: int = rng.randi_range(1, 5) #inclusive
			if piece_index == 1:
				board.add_child(preload("res://scenes/entities/paths/path_Bottom_Left.tscn").instance())
			elif piece_index == 2:
				board.add_child(preload("res://scenes/entities/paths/path_Bottom_Right.tscn").instance())
			elif piece_index == 3:
				board.add_child(preload("res://scenes/entities/paths/path_Left_Right.tscn").instance())
			elif piece_index == 4:
				board.add_child(preload("res://scenes/entities/paths/path_Up_Down.tscn").instance())
			elif piece_index == 5:
				board.add_child(preload("res://scenes/entities/special/special_Blank.tscn").instance())
	
	# pick one space in the first column for the start
	var start_row_ins: int = rng.randi_range(1, self.board_rows)
	_replaceBoardItemXY(board, start_row_ins, 1, preload("res://scenes/entities/special/special_Start.tscn").instance())
	
	# pick one space in the last column for the end
	var end_row_ins: int = rng.randi_range(1, self.board_rows)
	_replaceBoardItemXY(board, end_row_ins, self.board_cols, preload("res://scenes/entities/special/special_End.tscn").instance())
	
	var found_path: bool = false
	var winning_path: Array
	while !found_path:
		# pick a random point
		var row: int = rng.randi_range(1, self.board_rows)
		var col: int = rng.randi_range(1, self.board_cols)
		# pick a random adjacent point
		var dir: int = rng.randi_range(1, 4)
		if (dir == 1): # down
			if (row+1 <= self.board_rows):
				astar.connect_points(_rowColToIndex(row, col), _rowColToIndex(row+1, col), true)
		elif (dir == 2): # left
			if (col-1 >= 1):
				astar.connect_points(_rowColToIndex(row, col), _rowColToIndex(row, col-1), true)
		elif (dir == 3): # up
			if (row-1 >= 1):
				astar.connect_points(_rowColToIndex(row, col), _rowColToIndex(row-1, col), true)
		elif (dir == 4): # right
			if (col+1 <= self.board_cols):
				astar.connect_points(_rowColToIndex(row, col), _rowColToIndex(row, col+1), true)
		
		# check if there's a path
		if (astar.get_point_path(_rowColToIndex(start_row_ins, 1), _rowColToIndex(end_row_ins, self.board_cols)).size() != 0):
			winning_path = astar.get_point_path(_rowColToIndex(start_row_ins, 1), _rowColToIndex(end_row_ins, self.board_cols))
			found_path = true
	
	# adjust path pieces along the winning path so the player can use them
	for p in range(0, len(winning_path)):
		if (_getBoardItemXY(board, winning_path[p][0], winning_path[p][1]).name != "Start" and _getBoardItemXY(board, winning_path[p][0], winning_path[p][1]).name != "End"):
			# we add the appropriate piece to link up with the previous piece
			if (winning_path[p-1][0] == winning_path[p][0] and winning_path[p][0] == winning_path[p+1][0]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Left_Right.tscn").instance())
			if (winning_path[p-1][1] == winning_path[p][1] and winning_path[p][1] == winning_path[p+1][1]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Up_Down.tscn").instance())
			if (winning_path[p-1][0] == winning_path[p][0] and winning_path[p][1] == winning_path[p+1][1]) or (winning_path[p-1][1] == winning_path[p][1] and winning_path[p][0] == winning_path[p+1][0]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Bottom_Right.tscn").instance())
			if (winning_path[p-1][1] == winning_path[p][1] and winning_path[p][0] == winning_path[p+1][0]) or (winning_path[p-1][0] == winning_path[p][0] and winning_path[p][1] == winning_path[p+1][1]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Bottom_Right.tscn").instance())
			if (winning_path[p-1][0] == winning_path[p][0] and winning_path[p][1] == winning_path[p+1][1]) or (winning_path[p-1][1] == winning_path[p][1] and winning_path[p][0] == winning_path[p+1][0]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Bottom_Right.tscn").instance())
			if (winning_path[p-1][1] == winning_path[p][1] and winning_path[p][0] == winning_path[p+1][0]) or (winning_path[p-1][0] == winning_path[p][0] and winning_path[p][1] == winning_path[p+1][1]):
				_replaceBoardItemXY(board, winning_path[p][0], winning_path[p][1], preload("res://scenes/entities/paths/path_Bottom_Right.tscn").instance())



func _getBoardItemXY(board, row, col):
	return board.get_child(_rowColToIndex(row, col))
	
func _replaceBoardItemXY(board, row, col, item):
	var toremove = _getBoardItemXY(board, row, col)
	board.remove_child(toremove)
	_placeBoardItemXY(board, row, col, item)

func _placeBoardItemXY(board, row, col, item):
	board.add_child(item)
	board.move_child(item, _rowColToIndex(row, col))

func _rotatePiecePosition(board, row, col, degrees):
	# TODO: this doesn't seem to work, rotation likely is coming from a parent node
	var item = _getBoardItemXY(board, row, col)
	if (degrees == null):
		degrees = item.get_rotation_degrees() + 90
	item.set_rotation_degrees(degrees)
	

func _rowColToIndex(row, col):
	return (((row-1) * self.board_cols) + col)-1

func swapOutPowerup():
	var board = self.find_node("GridBoard", true, false)
	for row in range(1,board_rows+1):
		for col in range(1,board_cols+1):
			if _getBoardItemXY(board, row, col).name == "ExtraTime":
				var item = preload("res://scenes/entities/special/special_Blank.tscn").instance()
				_replaceBoardItemXY(board, row, col, item)
	
func createPowerup():
	var board = self.find_node("GridBoard", true, false)
	var rng = RandomNumberGenerator.new()
	rng.randomize() # sets up a random seed
	while true:
		# find a random blank spot to replace with the powerup
		var row: int = rng.randi_range(1, board_rows)
		var col: int = rng.randi_range(1, board_cols)
		if "type" in _getBoardItemXY(board, row, col) and _getBoardItemXY(board, row, col).type == "blank":
			var item = preload("res://scenes/entities/powerups/powerup_ExtraTime.tscn").instance()
			_replaceBoardItemXY(board, row, col, item)
			break
