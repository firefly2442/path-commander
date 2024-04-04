extends Control


func _ready():
	pass

func _on_CreditsRichTextLabel_meta_clicked(meta):
	var _err = OS.shell_open(meta)

func _on_Back_btn_pressed():
	SceneSwitcher.switch_scene("res://scenes/MainMenu.tscn")

func _exit_tree():
	self.queue_free()
