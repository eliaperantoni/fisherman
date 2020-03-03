extends Node2D

export var extent = 1
export (PackedScene) var tile_scene

const chunk_width = 512

func _ready():
	for i in extent:
		var left = tile_scene.instance()
		var right = tile_scene.instance()
		
		left.position.x = chunk_width*(i+1)
		right.position.x = -left.position.x
		
		add_child(left)
		add_child(right)
