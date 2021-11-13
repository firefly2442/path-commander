extends Control


func _ready():
	pass


func _on_Continue_btn_pressed():
	if Game.gametype == "tutorial":
		assert(get_tree().change_scene("res://scenes/TutorialSelection.tscn") == OK, "Error swapping scene")
	elif Game.gametype == "survival":
		assert(get_tree().change_scene("res://scenes/SurvivalSetup.tscn") == OK, "Error swapping scene")
