extends Control

func _ready():
	_set_oxygen(100)
	_set_life(100)
	_set_deep(0)

func _process(delta):
	self.player_moved(.get_parent().get_parent().get_node("Player").position.y)

func _set_oxygen(value):
	$Oxygen/Bar.value = value
	$Oxygen/Label.text = "O2 %s/100" % value
	$Oxygen/Label.text = "O2 %s/100" % value

func _set_life(value):
	$Life/Bar.value = value
	$Life/Label.text = "HB %s/100" % value

func _set_deep(value):
	$DeepCounter.text = "DEEP - %s m" % value

func _on_player_oxygen_modified(value):
	_set_oxygen(value)


func player_moved(position):
	var value = position/5
	if value<0:
		value=0
	value = int(value)
	_set_deep(value)


func _on_Player_life_modified(life):
	_set_life(life)
