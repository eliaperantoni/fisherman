extends HandTool

var cursor_scene = preload("res://scenes/tools/cursor/Cursor.tscn")
var cursor

func activate(player_arg):
	.activate(player_arg)
	cursor = cursor_scene.instance()
	get_tree().root.add_child(cursor)
	
func deactivate():
	get_tree().root.remove_child(cursor)
	cursor = null
	.deactivate()

func _process(_delta):
	rotation = (cursor.position - player.position).angle()
