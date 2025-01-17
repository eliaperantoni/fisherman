extends Node2D

class_name ToolBelt

var player
var backpack

signal tool_changed(old_tool_i, new_tool_i)

var current_tool_i setget set_current_tool_i
#var tools = {
#	1: {
#		obj = preload("res://scenes/tools/hand_tools/Flashlight.tscn").instance(),
#		texture = preload("res://scenes/tools/hand_tools/assets/flashlight.png")
#	}
#}
var tools = Global.tools


func _ready():
	for key in tools:
		tools[key].obj.toolbelt = self
	self.current_tool_i = 0

func set_current_tool_i(new_tool_i):
	print("[TOOLBELT] Switching tool to %d" % new_tool_i)
	
	emit_signal("tool_changed", current_tool_i, new_tool_i)
	
	if current_tool_i in tools:
		tools[current_tool_i].obj.deactivate()
	
	current_tool_i = new_tool_i
	
	if new_tool_i in tools:
		tools[current_tool_i].obj.activate()

func switch_tool_if_different(new_tool_i):
	if new_tool_i != current_tool_i:
		# The "self" here is necessary otherwise the setter won't be triggered
		self.current_tool_i = new_tool_i

func _input(ev):
	if ev is InputEventKey and ev.scancode >= KEY_1 and ev.scancode <= KEY_5:
		switch_tool_if_different(ev.scancode-KEY_1)
