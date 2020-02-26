extends RigidBody2D

export var drag_coefficient = 0.1
export var impulse_multiplier = 30000

export var oxygen_refill_rate = 10
export var oxygen_decrease_rate = 4

export var oxygen = 100 setget set_oxygen
func set_oxygen(new_oxygen):
	oxygen = clamp(new_oxygen, 0, 100)
	emit_signal("oxygen_modified", oxygen)

export var life = 100 setget set_life
func set_life(new_life):
	life = clamp(new_life, 0, 100)
	emit_signal("life_modified", life)

# When true player is on surface
var on_surface = true

# When true we try to make the player flot on water
var set_to_surface = true

var floating_height = 6

signal player_moved(position)
signal oxygen_modified(oxygen)
signal life_modified(life)

func _physics_process(delta):
	on_surface = position.y < 25
	
	self.linear_velocity *= (1 - drag_coefficient)

	var direction = get_user_direction()
	
	var impulse = direction * impulse_multiplier * delta
	if Input.is_key_pressed(KEY_SHIFT):
		impulse *= 4
	
	# Prevent flying
	if on_surface:
		impulse.y = max(impulse.y, 0)
	
	# If too far away from floating height
	if abs(floating_height-position.y) > 0.5:
		set_to_surface = false
	
	# If on surface and not yet stable and player not wanting to go downwards
	if on_surface and not set_to_surface and direction.y<=0:
		if abs(floating_height-position.y) >= 0.15:
			impulse.y = (6-position.y) * delta * 1600
		else:
			impulse.y = (6-position.y) * delta * 5000
			set_to_surface = true
	
	self.apply_central_impulse(impulse)
	
	if on_surface:
		self.oxygen += delta * oxygen_refill_rate
	else:
		self.oxygen -= delta * oxygen_decrease_rate

func is_ascending(direction):
	return direction.y < 0
	
func is_descending(direction):
	return direction.y > 0

func get_user_direction():
	var direction = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	
	direction = direction.normalized()

	return direction

func damage(points):
	self.life -= points
	
func get_y():
	return position.y
