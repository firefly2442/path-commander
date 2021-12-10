extends Control


func _ready():
	Game.level_node = preload("res://scenes/Level.tscn").instance()
	Game.gametype = "survival"


func _on_Start_btn_pressed():
	Game.level_node.board_rows = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/RowsSpinBox.value
	Game.level_node.board_cols = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/ColsSpinBox.value
	Game.timer.wait_time = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/TimerSpinBox.value
	Game.powerups_enabled = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/PowerupsCheckBox.pressed
	Game.infinite_mode = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer4/InfiniteModeCheckBox.pressed
	
	get_tree().get_root().add_child(Game.level_node)
	get_tree().set_current_scene(Game.level_node)
	get_tree().get_root().remove_child(get_tree().get_root().find_node("SurvivalSetup", true, false))


func _on_Back_btn_pressed():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == OK, "Error swapping scene")

func _exit_tree():
	self.queue_free()


func _on_PowerupHelpTextureRect_mouse_entered():
	var c = preload("res://scenes/instances/Popup_Help.tscn").instance()
	c.titletext = "Powerups"
	c.helptext = "Powerups grant extra time and other abilities when clicked."
	c.rect_position = get_viewport().get_mouse_position()
	get_tree().get_root().add_child(c)


func _on_PowerupHelpTextureRect_mouse_exited():
	get_tree().get_root().remove_child(get_tree().get_root().find_node("PopupHelp", true, false))


func _on_InfiniteModeHelpTextureRect_mouse_entered():
	var c = preload("res://scenes/instances/Popup_Help.tscn").instance()
	c.titletext = "Infinite Mode"
	c.helptext = "In infinite mode, you play and complete as many paths as you can before the timer runs out."
	c.rect_position = get_viewport().get_mouse_position()
	get_tree().get_root().add_child(c)


func _on_InfiniteModeHelpTextureRect_mouse_exited():
	get_tree().get_root().remove_child(get_tree().get_root().find_node("PopupHelp", true, false))
