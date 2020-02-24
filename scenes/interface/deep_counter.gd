extends Node

onready var label = $Value
var get_y_fn

var depth = 0 setget set_depth
func set_depth(new_depth):
	label.text = str(int(new_depth))

func _process(_delta):
	if get_y_fn:
		var y = get_y_fn.call_func()
		self.depth = int(max(0, y / 5))
