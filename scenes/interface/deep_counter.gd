extends Node

onready var label = $Value

var depth = 0 setget set_depth

func set_depth(new_depth):
	depth = new_depth
	label.text = str(depth)
