extends Node

var gametype = ""


func _ready():
	pass

func checkEvent():
	var board
	if gametype == "tutorial":
		board = TutorialLevel.find_node("Board")
	elif gametype == "survival":
		board = SurvivalLevel.find_node("Board")
	
	print(board)
	
	# check for win
	var start = board.find_node("Start")
	print(start)
	var win = _recursiveCheckWinPath(board, start)


func _recursiveCheckWinPath(board, node):
	# find all outbound paths from node
	# check it against the board grid
	#if node.up and board.
	_getBoardItemXY(board, node)
	

func _getBoardItemXY(board, node):
	var num_items: int = board.get_child_count()
	var columns: int = board.columns
	
	print("number items", num_items)
	print("columns", columns)
