extends GPUParticles2D


func _ready():
	self.one_shot = true

func _process(_delta):
	if !self.emitting:
		get_tree().get_root().remove_child(self)

func _exit_tree():
	self.queue_free()
