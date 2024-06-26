extends Control

var _settings := {resolution = Vector2i(1920, 1080), fullscreen = false, vsync = false}

func _ready():
	self._settings.fullscreen = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
	var fullscreen = self.find_child("FullScreenCheckBox", true, false)
	fullscreen.button_pressed = self._settings.fullscreen
	
	self._settings.vsync = (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)
	var vsync = self.find_child("VsyncCheckBox", true, false)
	vsync.button_pressed = self._settings.vsync
	
	var resolution = self.find_child("ResolutionOptionButton", true, false)
	for res in range(0, resolution.get_item_count()):
		var res_str: String = resolution.get_item_text(res)
		var values := res_str.split_floats("x")
		if get_window().get_size() == Vector2i(values[0], values[1]):
			resolution.selected = res
	
	var backgroundvol = self.find_child("BackgroundVolumeHSlider", true, false)
	var effectsvol = self.find_child("EffectsVolumeHSlider", true, false)
	backgroundvol.value = AudioManager.backgroundvolume
	effectsvol.value = AudioManager.effectsvolume

func _on_Back_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/MainMenu.tscn")

func _on_Save_btn_pressed():
	var resolution = self.find_child("ResolutionOptionButton", true, false)
	var res_str: String = resolution.get_item_text(resolution.get_selected_id())
	var values := res_str.split_floats("x")
	self._settings.resolution = Vector2i(values[0], values[1])
	
	var fullscreen = self.find_child("FullScreenCheckBox", true, false)
	self._settings.fullscreen = fullscreen.pressed
	
	var vsync = self.find_child("VsyncCheckBox", true, false)
	self._settings.vsync = vsync.pressed
	
	var backgroundvol = self.find_child("BackgroundVolumeHSlider", true, false)
	var effectsvol = self.find_child("EffectsVolumeHSlider", true, false)
	AudioManager.backgroundvolume = backgroundvol.value
	AudioManager.effectsvolume = effectsvol.value
	
	# apply the settings
	# https://www.gdquest.com/tutorial/godot/2d/settings-demo/
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (self._settings.fullscreen) else Window.MODE_WINDOWED
	get_window().set_size(self._settings.resolution)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (self._settings.vsync) else DisplayServer.VSYNC_DISABLED)
	

func _exit_tree():
	self.queue_free()
