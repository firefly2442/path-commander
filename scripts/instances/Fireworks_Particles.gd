extends Particles2D


func _ready():
	self.one_shot = true
	# pick a random color
	var rng = RandomNumberGenerator.new()
	rng.randomize() # sets up a random seed
	self.modulate = Color(rng.randf(), rng.randf(), rng.randf(), 1)

func _process(_delta):
	if !self.emitting:
		get_tree().get_root().remove_child(self)

func _exit_tree():
	self.queue_free()
