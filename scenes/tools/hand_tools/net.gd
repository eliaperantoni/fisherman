extends HandToolCursor

onready var area = $Sprite/Area2D
onready var animator = $AnimationPlayer

var in_cooldown = false

func _input(_event):
	if Input.is_action_just_pressed("tool_action_a") and not in_cooldown:
		animator.play("sweep")
		var closest_fish = get_closest_fish()
		# No fish
		if not closest_fish:
			return
		
		if toolbelt.backpack.add_fish(closest_fish):
			closest_fish.queue_free()
		
			in_cooldown = true
			yield(get_tree().create_timer(1), "timeout")
			in_cooldown = false

# Restituisce il rigid body più vicino al tool che faccia parte del gruppo
# "fish" altrimenti null
func get_closest_fish() -> RigidBody2D:
	var closest
	var dist = INF
	for body in area.get_overlapping_bodies():
		if not body.is_in_group("fish"):
			continue
		if (global_position - body.global_position).length() < dist:
			closest = body
	
	return closest
