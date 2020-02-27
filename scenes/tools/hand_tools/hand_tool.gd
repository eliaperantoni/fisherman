extends Sprite

class_name HandTool

var toolbelt

func get_hand():
	return toolbelt.player.get_node("Hand")

func activate():
	get_hand().add_child(self)
	
func deactivate():
	get_hand().remove_child(self)
