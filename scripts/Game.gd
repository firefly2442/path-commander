extends Node

var level_node
var gametype
var recursive_checked = []

signal won
signal lost

func _ready():
	pass

func checkEvent():
	var board = level_node.find_node("GridBoard", true, false)
	# check for win
	var start = board.find_node("Start")
	recursive_checked = []
	_recursiveCheckWinPath(level_node, board, start)


func _recursiveCheckWinPath(level, board, node):
	recursive_checked.append(node)
	if node.name == "End":
		emit_signal("won")
	
	# find all outbound paths from node
	# check it against the board grid
	var pos = _getXYNodePosition(level, board, node)
	if node.up and (pos[0]-1) > 0 and !recursive_checked.has(_getBoardItemXY(level, board, pos[0]-1, pos[1])) and _getBoardItemXY(level, board, pos[0]-1, pos[1]).down:
		_recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0]-1, pos[1]))
	if node.down and (pos[0]+1) <= level.board_rows and !recursive_checked.has(_getBoardItemXY(level, board, pos[0]+1, pos[1])) and _getBoardItemXY(level, board, pos[0]+1, pos[1]).up:
		_recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0]+1, pos[1]))
	if node.left and (pos[1]-1) > 0 and !recursive_checked.has(_getBoardItemXY(level, board, pos[0], pos[1]-1)) and _getBoardItemXY(level, board, pos[0], pos[1]-1).right:
		_recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0], pos[1]-1))
	if node.right and (pos[1]+1) <= level.board_cols and !recursive_checked.has(_getBoardItemXY(level, board, pos[0], pos[1]+1)) and _getBoardItemXY(level, board, pos[0], pos[1]+1).left:
		_recursiveCheckWinPath(level, board, _getBoardItemXY(level, board, pos[0], pos[1]+1))


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
