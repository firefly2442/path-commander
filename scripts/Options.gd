extends Control

var _settings := {resolution = Vector2(1920, 1080), fullscreen = false, vsync = false}

func _ready():
	self._settings.fullscreen = OS.window_fullscreen
	var fullscreen = self.find_node("FullScreenCheckBox", true, false)
	fullscreen.pressed = _settings.fullscreen
	
	self._settings.vsync = OS.vsync_enabled
	var vsync = self.find_node("VsyncCheckBox", true, false)
	vsync.pressed = _settings.vsync
	
	var resolution = self.find_node("ResolutionOptionButton", true, false)
	for res in range(0, resolution.get_item_count()):
		var res_str: String = resolution.get_item_text(res)
		var values := res_str.split_floats("x")
		if OS.get_window_size() == Vector2(values[0], values[1]):
			resolution.selected = res

func _on_Back_btn_pressed():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == OK, "Error swapping scene")

func _on_Save_btn_pressed():
	var resolution = self.find_node("ResolutionOptionButton", true, false)
	var res_str: String = resolution.get_item_text(resolution.get_selected_id())
	var values := res_str.split_floats("x")
	self._settings.resolution = Vector2(values[0], values[1])
	
	var fullscreen = self.find_node("FullScreenCheckBox", true, false)
	self._settings.fullscreen = fullscreen.pressed
	
	var vsync = self.find_node("VsyncCheckBox", true, false)
	self._settings.vsync = vsync.pressed
	
	# apply the settings
	# https://www.gdquest.com/tutorial/godot/2d/settings-demo/
	OS.window_fullscreen = _settings.fullscreen
	OS.set_window_size(_settings.resolution)
	OS.vsync_enabled = _settings.vsync
