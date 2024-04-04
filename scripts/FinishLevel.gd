extends Control


func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/ResultStatusLabel.text = Game.result_string
	# https://docs.godotengine.org/en/3.4/getting_started/scripting/gdscript/gdscript_format_string.html
	$MarginContainer/HBoxContainer/VBoxContainer/StopwatchLabel.text = "%s %.2f seconds" % [$MarginContainer/HBoxContainer/VBoxContainer/StopwatchLabel.text, Game.result_stopwatch]
	$MarginContainer/HBoxContainer/VBoxContainer/NumClicksLabel.text = "%d clicks" % [Game.result_num_clicks]
	$MarginContainer/HBoxContainer/VBoxContainer/PuzzlesCompletedLabel.text = "%d %s" % [Game.result_puzzles_completed, $MarginContainer/HBoxContainer/VBoxContainer/PuzzlesCompletedLabel.text]
	
	if Game.result_string == "Won":
		var rng = RandomNumberGenerator.new()
		rng.randomize() # sets up a random seed
		var screenSize = get_viewport().get_visible_rect().size
		for _i in range(0,4):
			var particles = preload("res://scenes/instances/Fireworks_Particles.tscn").instantiate()
			particles.position = Vector2(rng.randi_range(screenSize.x*.25, screenSize.x*.75), rng.randi_range(screenSize.y*.25, screenSize.y*.75))
			get_tree().get_root().add_child(particles)
			
		

func _on_Continue_btn_pressed():
	if Game.gametype == "tutorial":
		SceneSwitcher.switch_scene("res://scenes/TutorialSelection.tscn")
	elif Game.gametype == "survival":
		SceneSwitcher.switch_scene("res://scenes/SurvivalSetup.tscn")

func _exit_tree():
	self.queue_free()
