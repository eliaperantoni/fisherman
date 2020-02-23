extends Control

func _ready():
	_set_oxygen(100)
	_set_life(100)
	_set_deep(0)

func _set_oxygen(value):
	$OxygenBar.set_value(value)

func _set_life(value):
	$LifeBar.set_value(value)

func _set_deep(value):
	$DeepCounter.set_depth(value)

func _on_Player_oxygen_modified(value):
	_set_oxygen(value)

func _on_Player_player_moved(position):
	var value = position.y/5
	if value<0:
		value=0
	value = int(value)
	_set_deep(value)
