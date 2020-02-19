extends Node

var scenes = [
	{
		scene = preload("res://scenes/mobs/pacific/BasicPacificFish.tscn"),
		weight = 8,
	}
]

export var initial_spawn_amount: int

var total_weight = 8

func _ready():
	randomize()
	
	for i in initial_spawn_amount:
		_spawn_random_fish(_generate_random_coords())
	
func _spawn_random_fish(at: Vector2):
	var consume = randi() % total_weight
	var scene_index = 0
	
	while true:
		if consume < scenes[scene_index].weight:
			break
		else:
			consume -= scenes[scene_index].weight
	
	var scene = scenes[scene_index].scene
	var instance = scene.instance()
	instance.position = at
	add_child(instance)
	
func _generate_random_coords() -> Vector2:
	var x = rand_range(-600, 600)
	var y = rand_range(10, 3000)
	return Vector2(x, y)
