extends Panel

onready var toolbelt_display = $Bottom/HBoxContainer/Toolbet
onready var container_wanted = $Center/VBoxContainer/ScrollContainer/GridContainer
var rect_wanted = preload("res://scenes/menu/left_menu/ContainerWanted.tscn")
func _ready():
	toolbelt_display.set_toolset(Global.tools)

func add_wanted(fish,reward):
	var rect =  rect_wanted.instance()
	rect.set_texture(fish.get_texture())
	rect.set_reward(reward)
	container_wanted.add_child(rect)	
