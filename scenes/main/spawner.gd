extends Node

export (Array, PackedScene) var scenes

export var initial_spawn_amount: int

export var spawn_range_from = 10
export var spawn_range_to = 2700

func _ready():
	randomize()
	
	var spawned = 0
	while spawned < initial_spawn_amount:
		if try_spawning_random_fish(generate_random_coords()):
			spawned += 1
	
func try_spawning_random_fish(at: Vector2) -> bool:
	var scene = scenes[randi() % scenes.size()]
	var instance = scene.instance()
		
	if randf() > instance.spawn_curve.interpolate(y_to_0_1_range(at.y)):
		return false
	
	instance.position = at
	instance.add_to_group("fish")
	add_child(instance)
	
	return true

func generate_random_coords() -> Vector2:
	var x = rand_range(-600, 600)
	var y = rand_range(spawn_range_from, spawn_range_to)
	return Vector2(x, y)
	
func y_to_0_1_range(y):
	return (y - spawn_range_from)/(spawn_range_to - spawn_range_from)
