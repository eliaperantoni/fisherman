extends Control

func _ready():
	set_oxygen(100)
	set_life(100)
	set_depth(0)

func set_oxygen(value):
	$OxygenBar.set_value(value)

func set_life(value):
	$LifeBar.set_value(value)

func set_depth(value):
	$DeepCounter.set_depth(value)

func _on_Player_oxygen_modified(value):
	value = int(value)
	set_oxygen(value)

func _on_Player_player_moved(position):
	var value = position.y/5
	value = min(0, value)
	value = int(value)
	set_depth(value)
