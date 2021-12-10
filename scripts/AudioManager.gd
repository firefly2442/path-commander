extends Node

var num_players: int = 8

var available: Array = []  # The available players.
var queue: Array = []  # The queue of sounds to play.

var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

var backgroundvolume: int = -10
var effectsvolume: int = 0

# http://kidscancode.org/godot_recipes/audio/audio_manager/

func _ready():
	# set initial volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("background"), self.backgroundvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), self.effectsvolume)
	
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = "sfx"
	
	# setup the background music
	# imported to "loop" when finished
	add_child(background_music)
	background_music.stream = load("res://sounds/Flowing_Rocks.ogg")
	background_music.bus = "background"
	background_music.play()

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)


func _process(_delta):
	# apply any potential volume changes
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("background"), self.backgroundvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), self.effectsvolume)
	
	# Play a queued sound if any players are available.
	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
