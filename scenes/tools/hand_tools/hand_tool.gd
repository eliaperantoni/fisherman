extends Sprite

class_name HandTool

var player

func activate(player_arg):
	player = player_arg
	player.add_child(self)
	
func deactivate():
	player.remove_child(self)
	player = null
