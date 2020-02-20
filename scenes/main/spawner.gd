extends Node

var scenes = [
	preload("res://scenes/mobs/Fish1.tscn"),
	preload("res://scenes/mobs/Fish2.tscn"),
	preload("res://scenes/mobs/Fish3.tscn"),
	preload("res://scenes/mobs/Fish4.tscn"),
	preload("res://scenes/mobs/FishCarango.tscn"),
	preload("res://scenes/mobs/FishCarangoCrystal.tscn"),
	preload("res://scenes/mobs/FishIperoglife.tscn"),
	preload("res://scenes/mobs/FishMusicalis.tscn"),
	preload("res://scenes/mobs/FishOblungo.tscn"),
]

export var initial_spawn_amount: int

func _ready():
	randomize()
	
	for i in initial_spawn_amount:
		_spawn_random_fish(_generate_random_coords())
	
func _spawn_random_fish(at: Vector2):	
	var scene = scenes[randi() % scenes.size()]
	var instance = scene.instance()
	instance.position = at
	add_child(instance)
	
func _generate_random_coords() -> Vector2:
	var x = rand_range(-600, 600)
	var y = rand_range(10, 3000)
	return Vector2(x, y)
