extends Control


func _ready():
	pass


func _on_Start_btn_pressed():
	assert(get_tree().change_scene("res://scenes/SurvivalLevel.tscn") == OK, "Error swapping scene")

