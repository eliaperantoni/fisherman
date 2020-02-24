extends Node

export (Array, PackedScene) var scenes

export var initial_spawn_amount: int

func _ready():
	randomize()
	
	for i in initial_spawn_amount:
		_spawn_random_fish(_generate_random_coords())
	
func _spawn_random_fish(at: Vector2):	
	var scene = scenes[randi() % scenes.size()]
	var instance = scene.instance()
	instance.position = at
	
	self.get_parent().get_node("CanvasLayer/Interface/FishBar").addFish(instance)
	add_child(instance)
	
func _generate_random_coords() -> Vector2:
	var x = rand_range(-600, 600)
	var y = rand_range(10, 3000)
	return Vector2(x, y)
