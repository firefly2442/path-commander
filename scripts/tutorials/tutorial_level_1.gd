extends Control

func _ready():
	pass

func _exit_tree():
	self.queue_free()
