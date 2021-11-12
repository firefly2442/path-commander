extends Node

func _ready():
	pass

func _on_Exit_btn_pressed():
	# quit the game
	get_tree().quit()


func _on_Credits_btn_pressed():
	assert(get_tree().change_scene("res://scenes/Credits.tscn") == OK, "Error swapping scene")


func _on_Options_btn_pressed():
	assert(get_tree().change_scene("res://scenes/Options.tscn") == OK, "Error swapping scene")


func _on_Survival_btn_pressed():
	assert(get_tree().change_scene("res://scenes/SurvivalSetup.tscn") == OK, "Error swapping scene")


func _on_Tutorial_btn_pressed():
	assert(get_tree().change_scene("res://scenes/TutorialSelection.tscn") == OK, "Error swapping scene")
