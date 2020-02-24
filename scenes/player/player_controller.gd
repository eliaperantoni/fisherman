extends RigidBody2D

export var drag_coefficient = 0.1
export var impulse_multiplier = 50000

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

var can_swim = true

signal player_moved(position)
signal oxygen_modified(oxygen)
signal life_modified(life)

func _physics_process(delta):
	self.linear_velocity *= (1 - drag_coefficient)

	var direction = Vector2(0, 0)

	#D / right
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	#S / down
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	#A / left
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	#W / up
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
		
	direction = direction.normalized()
		
	var impulse = direction * delta * impulse_multiplier
	if Input.is_key_pressed(KEY_SHIFT):
		impulse *= 10
	
	self.apply_central_impulse(impulse)
	
	if can_swim:
		self.oxygen -= delta*oxygen_decrease_rate
	else:
		self.oxygen += delta*oxygen_refill_rate

func _on_water_entered(body):
	if body == self:
		can_swim = true
		self.gravity_scale = 0

func _on_water_exited(body):
	if body == self:
		can_swim = false
		self.gravity_scale = 10


func damage(points):
	self.life -= points
	
func get_y():
	return position.y
