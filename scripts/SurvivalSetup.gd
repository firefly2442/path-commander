extends Control


func _ready():
	Game.level_node = preload("res://scenes/Level.tscn").instance()
	Game.gametype = "survival"


func _on_Start_btn_pressed():
	Game.level_node.board_rows = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/RowsSpinBox.value
	Game.level_node.board_cols = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/ColsSpinBox.value
	Game.timer.wait_time = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/TimerSpinBox.value
	Game.powerups_enabled = $MarginContainer/HBoxContainer/VBoxContainer/PowerupsCheckBox.pressed
	
	get_tree().get_root().add_child(Game.level_node)
	get_tree().set_current_scene(Game.level_node)
	get_tree().get_root().remove_child(get_tree().get_root().find_node("SurvivalSetup", true, false))


func _on_Back_btn_pressed():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == OK, "Error swapping scene")

func _exit_tree():
	self.queue_free()
