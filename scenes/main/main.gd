extends Node2D

onready var player = $Player
onready var deep_counter = $CanvasLayer/Interface/DeepCounter
onready var life_bar = $CanvasLayer/Interface/LifeBar
onready var oxygen_bar =$CanvasLayer/Interface/OxygenBar
onready var fish_bar =$CanvasLayer/Interface/FishBar
onready var backpack = $Player/Backpack
onready var toolbelt = $Player/Toolbelt
onready var toolbelt_display = $CanvasLayer/Interface/Toolbelt

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	player.connect("player_moved", deep_counter, "on_player_moved")
	player.connect("life_modified", life_bar, "on_life_changed")
	player.connect("oxygen_modified", oxygen_bar, "on_oxygen_changed")

	toolbelt.connect("tool_changed", toolbelt_display, "on_tool_changed")
	
	backpack.connect("fish_added", fish_bar, "on_fish_added")

	fish_bar.max_value = backpack.max_value

	life_bar.on_life_changed(100)
	oxygen_bar.on_oxygen_changed(100)

	toolbelt_display.set_toolset(toolbelt.tools)
	toolbelt_display.on_tool_changed(0, toolbelt.current_tool_i)
	
	deep_counter.get_y_fn = funcref(player, "get_y")
	
	toolbelt.player = player
	toolbelt.backpack = backpack
