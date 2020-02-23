extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Player.connect("player_moved", $CanvasLayer/Interface/DeepCounter, "on_player_moved")
	$Player.connect("oxygen_modified", $CanvasLayer/Interface/OxygenBar, "on_oxygen_changed")
