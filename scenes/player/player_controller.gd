extends RigidBody2D

export var drag_coefficient = 0.1
export var impulse_multiplier = 50000

var canSwim = true

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

	if not canSwim:
		direction.y = 0

	self.apply_central_impulse(direction * delta * impulse_multiplier * (10 if Input.is_key_pressed(KEY_SHIFT) else 1))


func _on_water_entered(body):
	if body == self:
		canSwim = true
		self.gravity_scale = 0


func _on_water_exited(body):
	if body == self:
		canSwim = false
		self.gravity_scale = 3
