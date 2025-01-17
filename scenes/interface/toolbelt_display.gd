extends Node

var unselected_texture = preload("res://scenes/tools/assets/hud_placeholder.png")
var selected_texture = preload("res://scenes/tools/assets/hud_placeholder_selected.png")

func on_tool_changed(old_tool_i, new_tool_i):
	get_child(old_tool_i).texture = unselected_texture
	get_child(new_tool_i).texture = selected_texture
	
	for i in 5:
		get_child(i).show_behind_parent = true
		
	get_child(new_tool_i).show_behind_parent = false
	
func set_toolset(toolset):
	for i in 5:
		var texture
		if i in toolset:
			texture = toolset[i].texture
		get_child(i).get_node("Tool").texture = texture
