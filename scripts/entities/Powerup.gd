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
		var particles = preload("res://scenes/instances/Star_Particles.tscn").instance()
		get_tree().get_root().add_child(particles)
		particles.position = get_viewport().get_mouse_position()
		Game.extraTimeClicked()
		
