extends Node

onready var label = $Value

var depth = 0 setget set_depth

func set_depth(new_depth):
	label.text = str(int(new_depth))

func on_player_moved(position):
	var depth = position.y/5
	depth = max(0, depth)
	depth = int(depth)
	self.depth = depth
