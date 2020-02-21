extends Node

class_name ToolBelt

var player
func _init(player_arg):
	player = player_arg

var current_tool_i = 0 setget set_current_tool_i
var tools = {
	1: preload("res://scenes/tools/hand_tools/Flashlight.tscn").instance()
}

func set_current_tool_i(new_tool_i):
	print("[TOOLBELT] Switching tool to %d" % new_tool_i)
	
	if current_tool_i in tools:
		tools[current_tool_i].deactivate()
	
	current_tool_i = new_tool_i
	
	if new_tool_i in tools:
		tools[current_tool_i].activate(player)

func switch_tool_if_different(new_tool_i):
	if new_tool_i != current_tool_i:
		# The "self" here is necessary otherwise the setter won't be triggered
		self.current_tool_i = new_tool_i

func on_input(event):
	if event is InputEventKey and event.scancode >= KEY_1 and event.scancode <= KEY_5:
		switch_tool_if_different(event.scancode-KEY_1)
