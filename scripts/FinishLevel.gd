extends Control


func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/ResultStatusLabel.text = Game.result_string
	# https://docs.godotengine.org/en/3.4/getting_started/scripting/gdscript/gdscript_format_string.html
	$MarginContainer/HBoxContainer/VBoxContainer/StopwatchLabel.text = "%s %.2f seconds" % [$MarginContainer/HBoxContainer/VBoxContainer/StopwatchLabel.text, Game.result_stopwatch]
	$MarginContainer/HBoxContainer/VBoxContainer/NumClicksLabel.text = "%d clicks" % [Game.result_num_clicks]

func _on_Continue_btn_pressed():
	if Game.gametype == "tutorial":
		assert(get_tree().change_scene("res://scenes/TutorialSelection.tscn") == OK, "Error swapping scene")
	elif Game.gametype == "survival":
		assert(get_tree().change_scene("res://scenes/SurvivalSetup.tscn") == OK, "Error swapping scene")

func _exit_tree():
	self.queue_free()
