extends HandTool

class_name HandToolCursor

var cursor_scene = preload("res://scenes/tools/cursor/Cursor.tscn")
var cursor

func activate():
	.activate()
	cursor = cursor_scene.instance()
	get_tree().root.add_child(cursor)
	
func deactivate():
	get_tree().root.remove_child(cursor)
	cursor = null
	.deactivate()

func _process(_delta):
	rotation = (cursor.position - global_position).angle()
