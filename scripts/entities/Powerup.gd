extends Control

var up: bool = false
var down: bool = false
var left: bool = false
var right: bool = false

func _ready():
	pass

func _exit_tree():
	self.queue_free()

func _on_TextureButton_pressed():
	AudioManager.play("res://sounds/powerup.ogg")

	if self.name == "ExtraTime":
		Game.extraTimeClicked()
