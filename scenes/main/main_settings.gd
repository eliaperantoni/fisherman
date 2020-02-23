extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Toolbelt.connect("tool_changed", $CanvasLayer/Interface/Toolbelt, "on_tool_changed")
