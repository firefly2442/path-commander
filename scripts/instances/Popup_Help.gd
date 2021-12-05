extends Control

var titletext: String = ""
var helptext: String = ""

func _ready():
	$PanelContainer/VBoxContainer/HBoxContainer/TitleLabel.text = titletext
	$PanelContainer/VBoxContainer/HelperLabel.text = helptext

func _exit_tree():
	self.queue_free()
