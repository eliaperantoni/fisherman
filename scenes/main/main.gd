extends Node2D

onready var player = $Player
onready var deep_counter = $CanvasLayer/Interface/DeepCounter
onready var life_bar = $CanvasLayer/Interface/LifeBar
onready var oxygen_bar =$CanvasLayer/Interface/OxygenBar
onready var toolbelt = $Player/Toolbelt
onready var toolbelt_display = $CanvasLayer/Interface/Toolbelt

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	player.connect("player_moved", deep_counter, "on_player_moved")
	player.connect("oxygen_modified", oxygen_bar, "on_oxygen_changed")
	toolbelt.connect("tool_changed", toolbelt_display, "on_tool_changed")

	toolbelt_display.on_toolset_changed(toolbelt.tools)
	toolbelt_display.on_tool_changed(0, toolbelt.current_tool_i)
