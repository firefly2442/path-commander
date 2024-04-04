extends Control

func _ready():
	var board = self.find_child("BoardContainer", true, false)
	# prevent mouse interaction on the main menu graphic
	for c in board.get_children():
		if c.has_method("set_mouse_filter"):
			c.set_mouse_filter(2) # ignore mouse events
		for p in c.get_children():
			if p.has_method("set_mouse_filter"):
				p.set_mouse_filter(2) # ignore mouse events

func _on_Exit_btn_pressed():
	# quit the game
	get_tree().quit()

func _on_Credits_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/Credits.tscn")

func _on_Options_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/Options.tscn")

func _on_Survival_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/SurvivalSetup.tscn")

func _on_Tutorial_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/TutorialSelection.tscn")

func _exit_tree():
	self.queue_free()


func _on_Timer_timeout():
	# rotate a random piece
	var board = self.find_child("BoardContainer", true, false)
	var rng = RandomNumberGenerator.new()
	rng.randomize() # sets up a random seed
	var piece: int = rng.randi_range(1, 36)
	board.get_child(piece).set_rotation_degrees(board.get_child(piece).get_rotation_degrees() + 90)
